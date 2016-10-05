class AddSampleToItemArts < ActiveRecord::Migration
  def change
    add_column :item_arts, :is_sample, :boolean
    add_column :item_arts, :is_visible, :boolean
  end
end
