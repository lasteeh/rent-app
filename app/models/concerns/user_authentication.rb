module UserAuthentication
  extend ActiveSupport::Concern

  included do
    include BCrypt

    def self.signin(signin_params)
      user = find_by(email: signin_params[:email])
      if user && BCrypt::Password.new(user.password) == signin_params[:password]
        user.generate_token
        user.update_columns(token: user.token)

        return user, nil
      else
        error_messages = ['Invalid email or password']
        return user, error_messages
      end
    end

    def generate_token
      random_string = SecureRandom.urlsafe_base64(32)
      self.token = Digest::SHA256.hexdigest("#{random_string}-#{Time.now.to_i}")
    end
  end
end
