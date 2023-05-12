module UserAuthentication
  extend ActiveSupport::Concern

  included do
    include BCrypt

    def self.signin(signin_params)
      user = find_by(email: signin_params[:email])
      if user && signin_params[:password] == BCrypt::Password.new(user.password)
        return user, nil
      else
        error_messages = ['Invalid email or password']
        return user, error_messages
      end
    end
  end
end
