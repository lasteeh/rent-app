class Property < ApplicationRecord
  belongs_to :landlord

  validates :address, presence: true
  validates :city, presence: true
  validates :province, presence: true
  validates :zip_code, presence: true
end
