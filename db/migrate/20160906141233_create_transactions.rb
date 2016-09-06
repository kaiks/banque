class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float   :amount,      null: false
      t.integer :type,        null: false, default: 0
      t.integer :status,      null: false, default: 0
      t.integer :managed_by
      t.datetime :managed_at

      t.belongs_to :account, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
