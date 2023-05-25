class DateFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.nil?
      record.errors.add(attribute, 'must be in the format YYYY-MM-DD')
    else
      return value if value.is_a?(Date) || value.is_a?(DateTime)
      begin
        parsed_date = Date.strptime(value, '%Y-%m-%d')
      rescue ArgumentError
        record.errors.add(attribute, 'must be in the format YYYY-MM-DD')
      end
    end
  end
end
