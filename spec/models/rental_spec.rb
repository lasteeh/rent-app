require 'rails_helper'

RSpec.describe Rental, type: :model do
  let(:rental) { FactoryBot.create(:rental) }

  # validations
  describe 'validations' do
    subject { FactoryBot.create(:rental) }

    it { should validate_presence_of(:start_date) }
    it { should_not allow_value('october 52, 2025').for(:start_date) }
    it { should allow_value('2024-01-05').for(:start_date) }
    it { should allow_value('oct 10 2025').for(:start_date) }
    it { should_not allow_value('10 10 2025').for(:start_date) }
    it { should_not allow_value('may 18 2023').for(:start_date) }
    it { should_not allow_value('may 18 2020').for(:start_date) }

    it { should validate_presence_of(:duration_months) }
    it { should allow_value(50).for(:duration_months) }
    it { should_not allow_value(0).for(:duration_months) }
    it { should_not allow_value('0').for(:duration_months) }
    it { should_not allow_value(-8).for(:duration_months) }
    it do
      should_not allow_value('dancing in the moonlight').for(:duration_months)
    end

    it { should_not allow_value(nil).for(:renter_id) }
    it { should_not allow_value(nil).for(:property_id) }
  end

  # associations
  describe 'associations' do
    it { should belong_to(:renter) }
  end
end
