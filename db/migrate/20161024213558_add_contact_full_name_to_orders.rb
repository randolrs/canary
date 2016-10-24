class AddContactFullNameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :contact_full_name, :string
  end
end
