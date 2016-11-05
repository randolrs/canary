class AddHourToUserCall < ActiveRecord::Migration
  def change
    add_column :user_calls, :hour, :string
  end
end
