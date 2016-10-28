class AddMyReferralCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :my_referral_code, :string
  end
end
