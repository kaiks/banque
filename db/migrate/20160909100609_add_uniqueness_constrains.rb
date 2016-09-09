class AddUniquenessConstrains < ActiveRecord::Migration
  def change
    add_index :admins, :username, unique: true

    add_index :income_brackets, :min, unique: true
    add_index :income_brackets, :max, unique: true

    add_index :accounts, :number, unique: true
  end
end
