class CreateExhibitions < ActiveRecord::Migration
  def change
    create_table :exhibitions do |t|
      t.integer :user_id
      t.integer :city_id
      t.string :venue_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :state_or_province
      t.string :zip_or_postal_code
      t.string :country
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
