class Artist < ActiveRecord::Base


	belongs_to :user

	belongs_to :gallery

	has_many :item_arts

	has_many :shows
	
	has_attached_file :image, 
	:styles => { :medium => "100x100#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_person_photo.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


	def more_work(item, count)

    	return self.item_arts.where.not(id: item).last(count)

  	end


  	def related_artists
  		
  		@artists = Artist.all.where.not(id: self.id)

  		return @artists.last(3)

  	end


end
