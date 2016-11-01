class AddAboutToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :about, :text
    add_column :galleries, :year_opened, :integer
    add_column :galleries, :user_id, :integer
  end
end
