class AddContactEmailToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :contact_email, :string
  end
end
