class AddBillingActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :billing_active, :boolean
  end
end
