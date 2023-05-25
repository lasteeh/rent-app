class AddRentalsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals, id: :uuid do |t|
      t.date :start_date, null: false
      t.integer :duration_months, null: false, default: 1

      t.references :renter, null: false, foreign_key: true, type: :uuid
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
