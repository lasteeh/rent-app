class AddPropertiesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.string :address, null: false
      t.string :city, null: false
      t.string :province, null: false
      t.string :zip_code, null: false
      t.integer :units

      t.references :landlord, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
