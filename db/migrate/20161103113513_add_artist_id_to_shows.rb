class AddArtistIdToShows < ActiveRecord::Migration
  def change
    add_column :shows, :artist_id, :integer
  end
end
