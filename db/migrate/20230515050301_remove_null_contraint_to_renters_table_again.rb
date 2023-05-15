class RemoveNullContraintToRentersTableAgain < ActiveRecord::Migration[7.0]
  def up
    change_column_null :renters, :token, true
  end

  def down
    change_column_null :renters, :token, false
  end
end
