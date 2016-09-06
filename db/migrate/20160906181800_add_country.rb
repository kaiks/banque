class AddCountry < ActiveRecord::Migration
  def change
    add_column :users, :country_code, :string, limit: 2, null: false, default: 'FR'
  end
end
