require 'rails_helper'

RSpec.describe UserAuthentication, type: :concern do
  let(:test_model) do
    Class.new(ApplicationRecord) do
      self.table_name = 'landlords'
      include UserAuthentication
    end
  end

  let(:landlord) do
    FactoryBot.create(
      :landlord,
      email: 'testuser123@email.com',
      password: 'A1b2c3dddd!',
    )
  end
  let(:valid_credentials) do
    { email: landlord.email, password: landlord.password }
  end
  let(:invalid_credentials) do
    { email: landlord.email, password: 'wrong_password' }
  end

  describe '.signin' do
    context 'with valid credentials' do
      it 'returns the user without error messages' do
        user, error_messages = test_model.signin(valid_credentials)
        expect(user.attributes).to eq(landlord.attributes)
      end
    end

    context 'with invalid credentials' do
      it 'returns the user with error messages' do
        user, error_messages = test_model.signin(invalid_credentials)
        expect(error_messages).to eq(['Invalid email or password'])
      end
    end
  end

  describe '#generate_token' do
    it 'generates token for the user' do
      landlord.generate_token
      expect(landlord.token).not_to be_nil
    end
  end
end
