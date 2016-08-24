class AddAttachmentImageToItemArts < ActiveRecord::Migration
  def self.up
    change_table :item_arts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :item_arts, :image
  end
end
