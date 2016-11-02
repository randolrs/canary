class AddStripeAccountIdToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :stripe_account_id, :string
  end
end
