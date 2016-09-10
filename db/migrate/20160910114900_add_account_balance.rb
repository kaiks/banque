class AddAccountBalance < ActiveRecord::Migration
  def change
    add_column :accounts, :balance, :float, null: false, default: 0
  end
end
