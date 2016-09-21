class CreateStripeUserCustomers < ActiveRecord::Migration
  def change
    create_table :stripe_user_customers do |t|
      t.string :user_id
      t.string :stripe_customer_id

      t.timestamps null: false
    end
  end
end
