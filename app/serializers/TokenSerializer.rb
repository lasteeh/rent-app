class TokenSerializer
  def self.serialize_user(user)
    { id: user.id, email: user.email, token: user.token }
  end
end
