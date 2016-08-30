class AddArtistIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :artist_id, :integer
  end
end
