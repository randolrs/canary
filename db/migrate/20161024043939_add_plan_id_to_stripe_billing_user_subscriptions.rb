class AddPlanIdToStripeBillingUserSubscriptions < ActiveRecord::Migration
  def change
    add_column :stripe_billing_user_subscriptions, :plan_id, :string
    add_column :stripe_billing_user_subscriptions, :active, :boolean
  end
end
