class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    validates_uniqueness_of :display_name
    
  	has_many :exhibitions

  	has_many :item_arts

    has_many :views, :through => :item_arts

	has_attached_file :image, 
	:styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_:style.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def messages_to_me

    return Message.where(:recipient_id => self.id)

  end

  def messages_sent_by_me

    return Message.where(:sender_id => self.id)

  end

  def purchases_of_my_work

    return Purchase.where(:artist_id => self.id)

  end


  def recent_activity

    activity = Array.new

    self.views.each do |view|

      data = Hash.new

      data['type'] = "view"

      data['object'] = view

      data['created_at'] = view.created_at

      activity << data
      
    end

    self.purchases_of_my_work.each do |purchase|

      data = Hash.new

      data['type'] = "purchase"

      data['object'] = purchase

      data['created_at'] = purchase.created_at

      activity << data
      
    end

    return activity.sort_by { |k| k['created_at'] }.reverse


  end
  
end
