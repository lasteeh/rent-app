module UserAuthentication
  extend ActiveSupport::Concern

  included do
    include BCrypt

    def self.signin(signin_params)
      p 'inside sign in method'
      user = find_by(email: signin_params[:email])
      p "#{user.email} user email found"
      p "#{user.id} user id found"
      p "#{user.token} user token found"
      if user && BCrypt::Password.new(user.password) == signin_params[:password]
        p "#{user.token} token before generating token"
        user.generate_token
        p "#{user.token} token after generating token"

        if user.update_columns(token: user.token)
          p 'SAVE SUCCESSSS'
        else
          p "Error saving user: #{user.errors.full_messages.join(', ')}"
        end

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
