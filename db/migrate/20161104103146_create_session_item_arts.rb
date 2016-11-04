class CreateSessionItemArts < ActiveRecord::Migration
  def change
    create_table :session_item_arts do |t|
      t.integer :session_id
      t.integer :item_art_id

      t.timestamps null: false
    end
  end
end
