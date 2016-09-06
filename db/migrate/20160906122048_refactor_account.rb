class RefactorAccount < ActiveRecord::Migration
  def change
    rename_column :accounts, :state_id, :status
    change_column_default :accounts, :status, 0
    add_foreign_key :accounts, :users, column: :user_id
  end
end
