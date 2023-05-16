class BaseSerializer
  def self.serialize_user(user)
    {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
    }
  end
end
