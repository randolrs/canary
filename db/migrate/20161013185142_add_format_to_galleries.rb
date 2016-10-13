class AddFormatToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :number_of_images, :integer
    add_column :galleries, :include_artist_statement, :boolean
    add_column :galleries, :require_additional_description, :boolean
  end
end
