class AddExhibitIdToItemArts < ActiveRecord::Migration
  def change
    add_column :item_arts, :exhibit_id, :integer
  end
end
