class AddCityToExhibitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :city, :string
  end
end
