class ItemArt < ActiveRecord::Base

	belongs_to :user

	has_many :views

	has_many :purchases

	has_attached_file :image, 
	:styles => { :medium => "100x100#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_item_:style.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


	def self.search(search)
	    if search
	      return ItemArt.all.where(:search_code => search).last
	    else
	      return nil
	    end
  	end

  	def sold

  		return Purchase.where(:item_art_id => self.id).exists?

  	end


end
