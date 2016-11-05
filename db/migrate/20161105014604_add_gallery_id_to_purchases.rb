class AddGalleryIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :gallery_id, :integer
  end
end
