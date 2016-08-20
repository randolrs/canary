class AddCityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_city_id, :integer
  end
end
