class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :title,    :limit => 4
      t.string  :name,     :limit => 40
      t.string  :surname,  :limit => 80
      t.date    :birth_date
      t.string  :city,     :limit => 100
      t.integer :income_bracket, :limit => 45
      t.string  :password, :limit => 100

      t.timestamps null: false
    end
  end
end
