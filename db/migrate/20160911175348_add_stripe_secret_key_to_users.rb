class AddStripeSecretKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_secret_key, :string
  end
end
