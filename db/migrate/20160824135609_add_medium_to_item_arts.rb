class AddMediumToItemArts < ActiveRecord::Migration
  def change
    add_column :item_arts, :medium, :string, default: ""
  end
end
