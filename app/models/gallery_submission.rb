class GallerySubmission < ActiveRecord::Base

	has_one :collection

	belongs_to :gallery

	belongs_to :user

	def status

		unless self.paid

			return "Draft"

		else

			return "Sent to Gallery"

		end
		
	end

end
