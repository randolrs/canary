class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :email
      t.integer :user_id
      t.integer :amount
      t.string :description
      t.integer :item_art_id
      t.string :currency
      t.string :stripe_customer_id
      t.string :stripe_card_id

      t.timestamps null: false
    end
  end
end
