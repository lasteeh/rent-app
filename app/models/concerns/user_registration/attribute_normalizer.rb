module UserRegistration
  module AttributeNormalizer
    extend ActiveSupport::Concern

    included do
      before_validation :normalize_first_and_last_name
      before_validation :normalize_email_address
    end

    private

    def normalize_first_and_last_name
      self.first_name = normalize_name(self.first_name)
      self.last_name = normalize_name(self.last_name)
    end

    def normalize_email_address
      self.email = self.email.to_s.downcase.strip
    end

    def normalize_name(name)
      return '' if name.nil?

      name
        .split(/(\s|-)/)
        .map { |part| part.match?(/\s|-/) ? part : part.capitalize }
        .join
    end
  end
end
