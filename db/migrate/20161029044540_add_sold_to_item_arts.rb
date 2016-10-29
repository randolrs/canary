class AddSoldToItemArts < ActiveRecord::Migration
  def change
    add_column :item_arts, :is_set_to_sold, :boolean
  end
end
