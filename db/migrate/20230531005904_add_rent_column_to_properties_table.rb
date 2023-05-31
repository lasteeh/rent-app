class AddRentColumnToPropertiesTable < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :rent_per_month, :decimal, null: false
  end
end
