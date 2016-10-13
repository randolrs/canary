class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.string :city
      t.string :state_province
      t.string :country

      t.timestamps null: false
    end
  end
end
