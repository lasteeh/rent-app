require 'rails_helper'

RSpec.describe UserRegistration::AttributeNormalizer, type: :concern do
  let(:test_model) do
    Class.new(ApplicationRecord) do
      self.table_name = 'landlords'
      include UserRegistration::AttributeNormalizer
    end
  end

  let(:landlord) do
    FactoryBot.create(
      :landlord,
      first_name: 'HAk digity',
      last_name: 'dOG-gone',
      email: 'HAKDOG@EMail.com',
    )
  end
  let(:renter) do
    FactoryBot.create(
      :renter,
      first_name: 'HAm digitydo',
      last_name: 'dOGg-ggone',
      email: 'HAKDOGe@EMail.com',
    )
  end

  describe '#normalize_first_and_last_name' do
    it 'capitalizes the first letter of each name part before saving' do
      expect(landlord.reload.first_name).to eq('Hak Digity')
      expect(landlord.reload.last_name).to eq('Dog-Gone')
      expect(renter.reload.first_name).to eq('Ham Digitydo')
      expect(renter.reload.last_name).to eq('Dogg-Ggone')
    end
  end

  describe '#normalize_email_address' do
    it 'downcases and strips the email address before saving' do
      expect(landlord.reload.email).to eq('hakdog@email.com')
      expect(renter.reload.email).to eq('hakdoge@email.com')
    end
  end

  describe '#normalize_name' do
    it 'capitalizes the first letter of each name part correctly' do
      normalized_name = test_model.new.send(:normalize_name, 'HAk digity')
      expect(normalized_name).to eq('Hak Digity')
    end
  end
end
