class CreateStripeBillingUserSubscriptions < ActiveRecord::Migration
  def change
    create_table :stripe_billing_user_subscriptions do |t|
      t.integer :stripe_customer_id
      t.integer :user_id
      t.integer :stripe_plan_id

      t.timestamps null: false
    end
  end
end
