class Show < ActiveRecord::Base

	belongs_to :gallery

	has_many :item_arts

	has_attached_file :image, 
	:styles => { :medium => "100x100#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_item_photo.png',
	:s3_protocol => :https


end
