class AddPickInstructionsToItemArts < ActiveRecord::Migration
  def change
    add_column :item_arts, :pickup_instructions, :text
  end
end
