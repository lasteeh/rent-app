module NormalizeAttributes
  extend ActiveSupport::Concern

  included do
    before_save :normalize_first_and_last_name
    before_save :normalize_email_address
  end

  private

  def normalize_first_and_last_name
    self.first_name = normalize_name(self.first_name)
    self.last_name = normalize_name(self.last_name)
  end

  def normalize_email_address
    self.email = email.downcase.strip
  end

  def normalize_name(name)
    name
      .split(/(\s|-)/)
      .map { |part| part.match?(/\s|-/) ? part : part.capitalize }
      .join
  end
end
