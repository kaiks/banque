class AddNotNulls < ActiveRecord::Migration
  def change
    change_column_null :users, :birth_date, false
    change_column_null :users, :name, false
    change_column_null :users, :surname, false
    change_column_null :users, :city, false
    change_column_null :users, :income_bracket, false
    change_column_null :users, :title, false
    change_column_null :users, :password, false
  end
end
