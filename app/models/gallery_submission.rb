class GallerySubmission < ActiveRecord::Base

	has_many :collections

	belongs_to :gallery
end
