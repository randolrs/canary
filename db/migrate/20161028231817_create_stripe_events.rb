class CreateStripeEvents < ActiveRecord::Migration
  def change
    create_table :stripe_events do |t|
      t.string :stripe_id

      t.timestamps null: false
    end
  end
end
