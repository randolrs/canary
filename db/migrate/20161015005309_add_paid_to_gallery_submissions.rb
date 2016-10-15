class AddPaidToGallerySubmissions < ActiveRecord::Migration
  def change
    add_column :gallery_submissions, :paid, :boolean
    add_column :gallery_submissions, :cost, :decimal
  end
end
