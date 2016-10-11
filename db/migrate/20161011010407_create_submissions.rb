class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :gallery_id
      t.integer :artist_id

      t.timestamps null: false
    end
  end
end
