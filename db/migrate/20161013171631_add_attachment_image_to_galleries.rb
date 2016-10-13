class AddAttachmentImageToGalleries < ActiveRecord::Migration
  def self.up
    change_table :galleries do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :galleries, :image
  end
end
