class AddPasswordColumnToLandlordTable < ActiveRecord::Migration[7.0]
  def change
    add_column :landlords, :password, :string, null: false
  end
end
