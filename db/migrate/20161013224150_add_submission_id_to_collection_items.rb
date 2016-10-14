class AddSubmissionIdToCollectionItems < ActiveRecord::Migration
  def change
    add_column :collection_items, :gallery_submission_id, :integer
  end
end
