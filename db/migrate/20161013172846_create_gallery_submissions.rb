class CreateGallerySubmissions < ActiveRecord::Migration
  def change
    create_table :gallery_submissions do |t|
      t.integer :user_id
      t.integer :gallery_id
      t.integer :collection_id
      t.text :additional_description

      t.timestamps null: false
    end
  end
end
