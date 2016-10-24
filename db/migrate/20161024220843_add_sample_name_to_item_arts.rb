class AddSampleNameToItemArts < ActiveRecord::Migration
  def change
    add_column :item_arts, :sample_name, :string
  end
end
