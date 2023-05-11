class AddIndexToTokenInUsersTable < ActiveRecord::Migration[7.0]
  def change
    add_index :landlords, :token, unique: true
    add_index :renters, :token, unique: true
  end
end
