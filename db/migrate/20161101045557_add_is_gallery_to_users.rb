class AddIsGalleryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_gallery, :boolean
  end
end
