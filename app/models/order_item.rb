class OrderItem < ActiveRecord::Base

	has_one :item_art

	belongs_to :order

	def item_art

		
		return ItemArt.find(self.item_id)

	end


end
