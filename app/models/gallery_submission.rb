class GallerySubmission < ActiveRecord::Base

	has_one :collection

	belongs_to :gallery

	belongs_to :user

	def status

		return "Sent"
	end

end
