require 'rails_helper'

RSpec.describe Landlord, type: :model do
  it 'creates a valid landlord' do
    landlord = create(:landlord)
    expect(landlord).to be_valid
  end
end
