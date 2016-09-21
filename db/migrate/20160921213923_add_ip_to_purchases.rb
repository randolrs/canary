class AddIpToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :ip_address, :string
  end
end
