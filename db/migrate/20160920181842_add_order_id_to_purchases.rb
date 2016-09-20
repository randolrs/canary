class AddOrderIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :order_id, :integer
  end
end
