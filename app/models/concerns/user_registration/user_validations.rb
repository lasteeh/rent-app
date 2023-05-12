module UserRegistration
  module UserValidations
    extend ActiveSupport::Concern

    included do
      # attribute macros
      attr_accessor :password_confirmation

      # validations
      validates :first_name,
                presence: true,
                length: {
                  minimum: 1,
                },
                name_format: true
      validates :last_name,
                presence: true,
                length: {
                  minimum: 1,
                },
                name_format: true
      validates :email,
                email_format: true,
                presence: true,
                uniqueness: {
                  case_sensitive: false,
                }
      validates :phone_number,
                presence: true,
                uniqueness: {
                  case_sensitive: false,
                }
      validates :password,
                password_format: true,
                presence: true,
                length: {
                  minimum: 8,
                }
      validates :password_confirmation, presence: true, on: :create
      validate :password_match?
    end

    private

    def password_match?
      return if password.blank? || password_confirmation.blank?

      if password != password_confirmation
        errors.add :password_confirmation,
                   :mismatch,
                   message: "doesn't match Password"
      end
    end
  end
end
