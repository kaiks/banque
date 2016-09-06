class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :username, nil: false, limit: 20
      t.string :name,                 limit: 40
      t.string :surname,              limit: 100
      t.string :password, nil: false, limit: 100

      t.timestamps null: false
    end
  end
end
