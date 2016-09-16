class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :item_id
      t.integer :order_id
      t.string :status
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
