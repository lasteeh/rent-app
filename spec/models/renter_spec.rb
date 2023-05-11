require 'rails_helper'

RSpec.describe Renter, type: :model do
  let(:renter) { FactoryBot.create(:renter) }

  # validations
  describe 'validations' do
    subject { FactoryBot.create(:renter) }

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
  end
end
