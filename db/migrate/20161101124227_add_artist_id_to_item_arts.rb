class AddArtistIdToItemArts < ActiveRecord::Migration
  def change
    add_column :item_arts, :artist_id, :integer
  end
end
