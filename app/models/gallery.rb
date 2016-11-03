class Gallery < ActiveRecord::Base

	has_one :gallery_submission_format

	has_many :gallery_submissions

	has_many :users, :through => :gallery_users

	has_many :artists

	has_many :shows

	has_many :gallery_users

	has_many :item_arts, :through => :artists

	has_attached_file :image, 
	:styles => { :medium => "100x100#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_item_:style.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]



end
