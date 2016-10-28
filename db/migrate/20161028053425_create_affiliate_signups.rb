class CreateAffiliateSignups < ActiveRecord::Migration
  def change
    create_table :affiliate_signups do |t|
      t.integer :user_id
      t.integer :affiliate_id
      t.integer :affiliate_referral_id

      t.timestamps null: false
    end
  end
end
