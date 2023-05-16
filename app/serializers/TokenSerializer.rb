class TokenSerializer
  def self.serialize_user(user)
    { id: user.id, email: user.email, token: user.generate_token }
  end
end
