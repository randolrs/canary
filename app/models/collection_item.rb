class CollectionItem < ActiveRecord::Base

	belongs_to :collection

	has_one :item_art

	def object

		return ItemArt.find(self.item_art)
	
	end
end
