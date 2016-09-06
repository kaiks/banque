class CreateIncomeBrackets < ActiveRecord::Migration
  def change
    create_table :income_brackets do |t|
      t.integer :min, null: false
      t.integer :max

      t.timestamps null: false
    end
  end
end
