class AddSessionOptionIdToSessionItemArts < ActiveRecord::Migration
  def change
    add_column :session_item_arts, :session_option_id, :string
  end
end
