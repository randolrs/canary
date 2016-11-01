class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.text :biography
      t.text :artist_statement
      t.string :birth_year
      t.string :nationality
      t.integer :user_id
      t.integer :gallery_id
      t.boolean :is_user

      t.timestamps null: false
    end
  end
end
