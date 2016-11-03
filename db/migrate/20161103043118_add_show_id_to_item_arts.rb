class AddShowIdToItemArts < ActiveRecord::Migration
  def change
    add_column :item_arts, :show_id, :integer
  end
end
