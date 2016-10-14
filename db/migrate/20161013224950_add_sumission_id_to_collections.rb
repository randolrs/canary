class AddSumissionIdToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :gallery_submission_id, :integer
  end
end
