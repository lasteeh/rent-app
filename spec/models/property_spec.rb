require 'rails_helper'

RSpec.describe Property, type: :model do
  let(:property) { FactoryBot.create(:property) }

  # validations
  describe 'validations' do
    subject { FactoryBot.create(:property) }

    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:province) }
    it { should validate_presence_of(:zip_code) }
    #   it { should validate_presence_of(:maximum_occupants) }
  end

  # associations
  describe 'associations' do
    it { should belong_to(:landlord) }
  end
end
