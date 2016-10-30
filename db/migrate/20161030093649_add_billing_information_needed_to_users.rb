class AddBillingInformationNeededToUsers < ActiveRecord::Migration
  def change
    add_column :users, :billing_information_needed, :boolean
  end
end
