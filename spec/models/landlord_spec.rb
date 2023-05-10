require 'rails_helper'

RSpec.describe Landlord, type: :model do
  let(:landlord) { FactoryBot.create(:landlord) }

  # validations
  describe 'validations' do
    subject { FactoryBot.create(:landlord) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should_not allow_value('hakdog.email.com').for(:email) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_uniqueness_of(:phone_number).case_insensitive }
  end

  # callbacks
  describe 'callbacks' do
    it 'normalizes the first name before saving' do
      landlord.first_name = 'HAk'
      landlord.save
      expect(landlord.reload.first_name).to eq('Hak')
    end

    it 'normalizes the last name before saving' do
      landlord.last_name = 'dOG'
      landlord.save
      expect(landlord.reload.last_name).to eq('Dog')
    end

    it 'normalizes the email address before saving' do
      landlord.email = 'HAKDOG@EMail.com'
      landlord.save
      expect(landlord.reload.email).to eq('hakdog@email.com')
    end
  end
end
