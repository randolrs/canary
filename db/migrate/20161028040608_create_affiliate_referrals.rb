class CreateAffiliateReferrals < ActiveRecord::Migration
  def change
    create_table :affiliate_referrals do |t|
      t.string :ip_address
      t.string :referral_url
      t.string :affiliate_id

      t.timestamps null: false
    end
  end
end
