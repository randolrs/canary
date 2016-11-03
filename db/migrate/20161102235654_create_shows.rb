class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.boolean :is_festival
      t.string :name
      t.datetime :begin_date
      t.datetime :end_date
      t.boolean :open_to_public
      t.integer :gallery_id

      t.timestamps null: false
    end
  end
end
