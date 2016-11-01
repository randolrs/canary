class CreateGalleryUsers < ActiveRecord::Migration
  def change
    create_table :gallery_users do |t|
      t.integer :user_id
      t.integer :gallery_id
      t.boolean :active

      t.timestamps null: false
    end
  end
end
