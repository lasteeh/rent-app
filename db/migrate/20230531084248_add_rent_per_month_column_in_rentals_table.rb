class AddRentPerMonthColumnInRentalsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :rent_per_month, :decimal
  end
end
