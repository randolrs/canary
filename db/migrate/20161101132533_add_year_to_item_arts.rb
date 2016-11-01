class AddYearToItemArts < ActiveRecord::Migration
  def change
    add_column :item_arts, :year_of_creation, :integer
  end
end
