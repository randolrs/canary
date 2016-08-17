class CreateItemArts < ActiveRecord::Migration
  def change
    create_table :item_arts do |t|
      t.integer :user_id
      t.text :description
      t.string :name
      t.decimal :height
      t.decimal :width
      t.decimal :length
      t.integer :venue_id
      t.decimal :price
      t.string :search_code

      t.timestamps null: false
    end
  end
end
