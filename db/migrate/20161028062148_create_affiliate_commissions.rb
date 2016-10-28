class CreateAffiliateCommissions < ActiveRecord::Migration
  def change
    create_table :affiliate_commissions do |t|
      t.integer :user_id
      t.integer :affiliate_id
      t.decimal :amount
      t.boolean :recurring

      t.timestamps null: false
    end
  end
end
