class IncomeBracketsAssoc < ActiveRecord::Migration
  def change
    rename_column :users, :income_bracket, :income_bracket_id
    change_column :users, :income_bracket_id, :string, :limit => nil
    add_foreign_key :users, :income_brackets, column: :income_bracket_id
  end
end
