require 'rails_helper'

RSpec.describe NormalizeAttributes, type: :concern do
  let(:test_model) do
    Class.new(ApplicationRecord) do
      self.table_name = 'landlords'
      include NormalizeAttributes
    end
  end

  subject(:landlord) { FactoryBot.create(:landlord) }

  describe '#normalize_first_and_last_name' do
    it 'capitalizes the first letter of each name part before saving' do
      landlord.first_name = 'HAk digity'
      landlord.last_name = 'dOG-gone'
      landlord.save
      expect(landlord.reload.first_name).to eq('Hak Digity')
      expect(landlord.reload.last_name).to eq('Dog-Gone')
    end
  end

  describe '#normalize_email_address' do
    it 'downcases and strips the email address before saving' do
      landlord.email = 'HAKDOG@EMail.com'
      landlord.save
      expect(landlord.reload.email).to eq('hakdog@email.com')
    end
  end
end
