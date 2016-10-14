class Gallery < ActiveRecord::Base

	has_one :gallery_submission_format

	has_many :gallery_submissions
end
