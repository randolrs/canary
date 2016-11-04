class CreateContactQuestions < ActiveRecord::Migration
  def change
    create_table :contact_questions do |t|
      t.string :email
      t.text :message

      t.timestamps null: false
    end
  end
end
