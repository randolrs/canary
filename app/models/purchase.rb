class Purchase < ActiveRecord::Base

	belongs_to :item_art

	belongs_to :user

	belongs_to :gallery

	def status_as_string

		return "Awaiting Delivery"
		
	end

	
end
