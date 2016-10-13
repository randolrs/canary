class CreateCollectionItems < ActiveRecord::Migration
  def change
    create_table :collection_items do |t|
      t.integer :user_id
      t.integer :collection_id
      t.integer :item_art_id

      t.timestamps null: false
    end
  end
end
