class AddUseDefaultCardToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :use_default_card, :boolean
  end
end
