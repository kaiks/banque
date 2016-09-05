class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string  :number,      limit: 11, null: false
      t.integer :bank_code,   limit: 3, null: false
      t.integer :sort_code,   limit: 3, null: false
      t.integer :rib,         limit: 1

      t.integer :state_id,    null: false
      t.integer :user_id,     null: false
      t.timestamps null: false

      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
