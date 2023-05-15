require 'rails_helper'

RSpec.describe Landlord, type: :model do
  let(:landlord) { FactoryBot.create(:landlord) }
  let(:property) { FactoryBot.create(:property) }

  # validations
  describe 'validations' do
    subject { FactoryBot.create(:landlord) }

    it { should validate_presence_of(:first_name) }
    it { should allow_value('hak dog').for(:first_name) }
    it { should_not allow_value('hak !!! dog').for(:first_name) }
    it { should_not allow_value(' - ').for(:first_name) }

    it { should validate_presence_of(:last_name) }
    it { should allow_value('sam-smith').for(:last_name) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should_not allow_value('hakdog.email.com').for(:email) }

    it { should validate_presence_of(:phone_number) }
    it { should validate_uniqueness_of(:phone_number).case_insensitive }

    it { should_not allow_value('1234567').for(:password) }
    it { should_not allow_value('12345678').for(:password) }
    it { should_not allow_value('12345678a').for(:password) }
    it { should_not allow_value('12345678aA').for(:password) }
    it { should allow_value('12345678aA.').for(:password) }

    it 'should validate matching password and password confirmation' do
      landlord.password = 'a1b2c3DDDD!'
      landlord.password_confirmation = 'a1b2c3DDDD!!'
      expect(landlord).to_not be_valid
    end
  end

  # associations
  describe 'associations' do
    it { should have_many(:property) }
  end
end
