module UserRegistration
  extend ActiveSupport::Concern

  included do
    include BCrypt

    # callbacks
    before_save :hash_password

    # account creation
    def self.signup(signup_params)
      landlord = new(signup_params)

      if landlord.save
        return landlord, nil
      else
        error_messages = landlord.errors.full_messages
        return landlord, error_messages
      end
    end

    # password hashing
    def hash_password
      self.password = BCrypt::Password.create(self.password)
    end
  end
end
