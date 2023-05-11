class AddTokenColumnInLandlordTable < ActiveRecord::Migration[7.0]
  def change
    add_column :landlords, :token, :string, unique: true, null: false
  end
end
