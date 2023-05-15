class RemoveNullContraintToRentersTable < ActiveRecord::Migration[7.0]
  def up
    change_column_null :landlords, :token, true
  end

  def down
    change_column_null :landlords, :token, false
  end
end
