class AddCustomerIdToStripeEvent < ActiveRecord::Migration
  def change
    add_column :stripe_events, :stripe_customer_id, :string
  end
end
