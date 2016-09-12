class AddSecurePasswordToAdmin < ActiveRecord::Migration
  def change
    remove_column :admins, :password
    add_column :admins,:password_digest, :string
  end
end
