class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :item_art_id
      t.string :visitor_ip

      t.timestamps null: false
    end
  end
end
