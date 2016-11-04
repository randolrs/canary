class AddUserIdToSessionItemArts < ActiveRecord::Migration
  def change
    add_column :session_item_arts, :user_id, :integer
  end
end
