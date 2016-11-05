class AddPhoneNumberToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :phone_number, :string
    add_column :galleries, :website_title, :string
    add_column :galleries, :website_url, :string
  end
end
