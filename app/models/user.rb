class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    #validates_uniqueness_of :display_name
    
  	has_many :exhibitions

  	has_many :item_arts

    has_many :purchases

    has_many :collections

    has_many :gallery_submissions

    has_many :views, :through => :item_arts

	has_attached_file :image, 
	:styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_:style.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def messages_to_me

    return Message.where(:recipient_id => self.id, :parent_message_id => nil)

  end

  def messages_sent_by_me

    return Message.where(:sender_id => self.id)

  end

  def purchases_of_my_work

    return Purchase.where(:artist_id => self.id)

  end

  def total_revenue

    return self.purchases_of_my_work.sum("amount")

  end

  def affiliate_link

    affiliate_link = "https://www.ArtYam.com?affid=" + self.my_referral_code
    
    return affiliate_link

  end

  def trial_expired

    if self.trial_end_date

      return Time.now > self.trial_end_date

    else

      return false

    end

  end

  def affiliate_referrals(time_period)

    all_affiliate_referrals = AffiliateReferral.where(:affiliate_id => self.id)
    
    if time_period == "this-month"

      return all_affiliate_referrals.where(:created_at=> Time.now.beginning_of_month..Time.now.end_of_month)

    elsif time_period == "this-year"

      return all_affiliate_referrals.where(:created_at=> Time.now.beginning_of_year..Time.now.end_of_year)

    else

      return all_affiliate_referrals

    end

  end


  def affiliate_signups(time_period)

    #all_affiliate_signups = AffiliateSignup.where(:affiliate_id => self.id)

    all_affiliate_signups = AffiliateSignup.where(:affiliate_id => self.id)
    
    if time_period == "this-month"

      return all_affiliate_signups.where(:created_at=> Time.now.beginning_of_month..Time.now.end_of_month)

    elsif time_period == "this-year"

      return all_affiliate_signups.where(:created_at=> Time.now.beginning_of_year..Time.now.end_of_year)

    else

      return all_affiliate_signups

    end

  end



  def affiliate_commissions(time_period)

    #all_affiliate_signups = AffiliateSignup.where(:affiliate_id => self.id)

    all_affiliate_commissions = AffiliateCommission.where(:affiliate_id => self.id)
    
    if time_period == "this-month"

      return all_affiliate_commissions.where(:created_at=> Time.now.beginning_of_month..Time.now.end_of_month)

    elsif time_period == "this-year"

      return all_affiliate_commissions.where(:created_at=> Time.now.beginning_of_year..Time.now.end_of_year)

    else

      return all_affiliate_commissions

    end

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

  def stripe_balance

      if self.stripe_secret_key

        Stripe.api_key = self.stripe_secret_key

        balance_object = Stripe::Balance.retrieve()

        @user_stripe_balance = (balance_object.available[0]['amount'] + balance_object.pending[0]['amount']) / 100

        Stripe.api_key = ENV['STRIPE_SECRET_KEY']

        return @user_stripe_balance

      else

        return 0

      end

  end

  def stripe_transfers

    if self.stripe_secret_key

        Stripe.api_key = self.stripe_secret_key

        @transfers =  Stripe::Transfer.list()

        Stripe.api_key = ENV['STRIPE_SECRET_KEY']

        return @transfers

      else

        return nil

      end

  end

  def is_me(user)

    return self.id == user.id

  end

  def more_work(item, count)

    return self.item_arts.where.not(id: item).last(count)

  end

  def recommended_artwork(count)

    @item_arts = Array.new

    ItemArt.all.each do |item|

      unless item.sold
        @item_arts << item
      end

    end


    return @item_arts.last(count)

    # return ItemArt.all
    
  end

  def recommended_artists(count)

    @artists = Array.new

    User.where(:is_artist => true).each do |user|

      if user.item_arts.count > 0 && user.display_name
        @artists << user
      end

    end


    return @artists
    
  end

  def stripe_customer_object

    if StripeUserCustomer.exists?(:user_id => self.id)
    
      stripe_customer_id = StripeUserCustomer.where(:user_id => self.id).last.stripe_customer_id

      return Stripe::Customer.retrieve(stripe_customer_id)

    else

      return nil

    end 

  end

  def stripe_default_card_object

    customer = self.stripe_customer_object


    if customer

      card = customer.sources.retrieve(customer.default_source)

      if card

        return card

      else

        return nil
        
      end

    else

      return nil
    end

  end


  def stripe_account_object

    if self.stripe_account_id

      return Stripe::Account.retrieve(self.stripe_account_id)

    else

      return nil
    end


  rescue Stripe::AccountError => e
      return nil
  end

  def is_gallery

    return false
  
  end


  def galleries_for_submission

    user_gallery_submission_array = self.gallery_submissions.pluck(:gallery_id)

    return Gallery.where.not(id: user_gallery_submission_array)

  end

  def pickup_instruction_count

    @item_arts_with_pickup_instructions = self.item_arts.where.not(:pickup_instructions => nil)

    return @item_arts_with_pickup_instructions.last

  end


  def last_pickup_instructions

    @item_arts_with_pickup_instructions = self.item_arts.where.not(:pickup_instructions => nil)

    if @item_arts_with_pickup_instructions.count > 0

      @last_item_art_with_pickup_instructions = @item_arts_with_pickup_instructions.order("created_at").last

      return @last_item_art_with_pickup_instructions.pickup_instructions

    else

      return nil

    end

  end
  
end
