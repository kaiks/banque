class RenameRibToRibKey < ActiveRecord::Migration
  def change
    rename_column :accounts, :rib, :rib_key
    change_column_null :accounts, :rib_key, false
  end
end
