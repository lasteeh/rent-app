class AddTokenColumnInRenterTable < ActiveRecord::Migration[7.0]
  def change
    add_column :renters, :token, :string, unique: true, null: false
  end
end
