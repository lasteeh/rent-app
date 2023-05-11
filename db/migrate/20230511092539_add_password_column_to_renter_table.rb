class AddPasswordColumnToRenterTable < ActiveRecord::Migration[7.0]
  def change
    add_column :renters, :password, :string, null: false
  end
end
