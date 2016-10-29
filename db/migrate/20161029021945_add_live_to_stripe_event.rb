class AddLiveToStripeEvent < ActiveRecord::Migration
  def change
    add_column :stripe_events, :live, :boolean
  end
end
