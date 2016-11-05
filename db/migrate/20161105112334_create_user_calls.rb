class CreateUserCalls < ActiveRecord::Migration
  def change
    create_table :user_calls do |t|
      t.integer :user_id
      t.datetime :scheduled_time

      t.timestamps null: false
    end
  end
end
