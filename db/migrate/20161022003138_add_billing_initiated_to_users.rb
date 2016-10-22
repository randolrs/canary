class AddBillingInitiatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :billing_initiated, :boolean
  end
end
