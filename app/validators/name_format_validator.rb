class NameFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?

    unless value.match?(
             /^(?=.*[a-zA-Z])[a-zA-Z]+(?:-[a-zA-Z]+)*(?:\s[a-zA-Z]+(?:-[a-zA-Z]+)*)*$/,
           )
      record.errors.add(
        attribute,
        :invalid,
        message: 'can only contain letters, spaces, and hyphens',
      )
    end
  end
end
