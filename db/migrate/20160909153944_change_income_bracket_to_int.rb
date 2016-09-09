class ChangeIncomeBracketToInt < ActiveRecord::Migration
  def change
    change_column :users, :income_bracket_id, :integer, null: false
  end
end
