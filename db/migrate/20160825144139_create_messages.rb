class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.string :recipient_id
      t.string :subject, :default => "(No subject)"
      t.text :body

      t.timestamps null: false
    end
  end
end
