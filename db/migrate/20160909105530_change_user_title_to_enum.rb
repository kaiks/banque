class ChangeUserTitleToEnum < ActiveRecord::Migration
  def change
    change_column :users, :title, :integer, null: false
  end
end
