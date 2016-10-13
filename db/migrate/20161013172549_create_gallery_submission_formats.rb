class CreateGallerySubmissionFormats < ActiveRecord::Migration
  def change
    create_table :gallery_submission_formats do |t|
      t.integer :gallery_id
      t.integer :number_of_images
      t.boolean :include_artist_statement
      t.boolean :require_additional_description

      t.timestamps null: false
    end
  end
end
