class Collection < ActiveRecord::Base

	has_many :collection_items

	has_many :item_arts, :through => :collection_items

	belongs_to :user

	belongs_to :gallery_submission

	def items

		item = Array.new

		self.collection_items.each do |collection_item|

			if ItemArt.where(:id => collection_item.item_art_id).exists?

				item << ItemArt.where(:id => collection_item.item_art_id).last

			end

		end

		return item

	end

end
