class PasswordFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?

    unless value.match?(
             /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!#$%&*+,-.?@_])[A-Za-z0-9!#$%&*+,-.?@_]{3,}$/,
           )
      record.errors.add(
        attribute,
        :invalid,
        message:
          'must contain atleast a capital letter, a number, and a special character',
      )
    end
  end
end
