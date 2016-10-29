class AddStripeSubscriptionCustomerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_subscription_customer_id, :string
  end
end
