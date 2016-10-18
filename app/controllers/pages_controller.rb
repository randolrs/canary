class PagesController < ApplicationController

	#skip_before_filter :verify_authenticity_token #####****this is a workaround with POSSIBLE SECURITY GAPS####***

	def home

		@page = "home"

		@hide_return_to_home = true

		if user_signed_in?
			
			if current_user.is_artist

				@hide_header = true
				@page_title = "Home"

			else

				@page_title = "ArtYam"

			end

		else

			@hide_header_on_all_devices = true
			@hide_header = true
			@hide_footer = true

		end
		
	end

	def engagement

		@page_title = "Engagement"

		@page = "engagement" 

		@hide_header = true

	end

	def login

		@hide_header = true
		@hide_header_on_all_devices = true
		@hide_footer = true


	end



	def about

		@page_title = "About"

	end

	def settings

		@page_title = "Account Settings"

		@page = "settings"

		if user_signed_in?
			@hide_header = true
		end

	end

	def customer_payment_settings
		
		if user_signed_in?

			@page_title = "Settings"

			@page = "payment settings"

			@hide_header = true

			@stripe_customer_object = current_user.stripe_customer_object

			if @stripe_customer_object 

				@customer_cards = Stripe::Customer.retrieve(@stripe_customer_object.id).sources.all(:object => "card")
			end

		else

			redirect_to root_path
		end

	end

	def payment_settings

		@page_title = "Settings"

		@page = "payment settings"

		if user_signed_in?
			@hide_header = true
		end

		if user_signed_in?

			account = Stripe::Account.retrieve(current_user.stripe_account_id)

			@dob_object = account.legal_entity.dob

			if @dob_object["month"].to_s.length == 1

				@dob_month = "0" + @dob_object["month"].to_s

			else

				@dob_month = @dob_object["month"].to_s

			end

			if @dob_object["day"].to_s.length == 1 

				@dob_day = "0" + @dob_object["day"].to_s

			else

				@dob_day = @dob_object["day"].to_s

			end

			@dob_year = @dob_object["year"].to_s


			@firstName = account.legal_entity.first_name

			@lastName = account.legal_entity.last_name

			account.legal_entity.address.country = params[:country]


			@addressLine1 = account.legal_entity.address.line1

			@addressLine2 = account.legal_entity.address.line2

			@city = account.legal_entity.address.city

			@postalCode = account.legal_entity.address.postal_code

			@stateProvince = account.legal_entity.address.state

		else

			redirect_to root_path

		end

	end


	def sales

		@page="sales"

		@page_title = "Sales"

		if user_signed_in?
			@hide_header = true
		end

	end

	def balance_payments

		@page = "balance"

		@page_title = "Balance"

		if user_signed_in?
			@hide_header = true

		end

	end

	def views

		@page_title = "Views"

		@page = "views"

		if user_signed_in?
			@hide_header = true
		end


	end

	def messages

		@page = "messages"

		@page_title = "Inbox"

		if user_signed_in?
			@hide_header = true
		end


	end

	def my_work

		@page = "work"

		@page_title = "Portfolio"

		if user_signed_in?
			@hide_header = true
		end

	end

	def email_to_me

		@item_art = ItemArt.find(params[:item_art_id])

		UserMailer.email_to_me(@item_art, params[:email]).deliver_later

		redirect_to :back

	end

	def profile

		@user = User.find_by_display_name(params[:display_name])

		if user_signed_in?

			if current_user.is_me(@user)

				@page_title = "My Public Profile"

			else

				@page_title = @user.display_name.possessive + " Profile"

			end

		else

			@page_title = @user.display_name.possessive + " Profile"

		end

		@message = Message.new

		@message_recipient = @user

	end

	def profile_about

		@user = User.find_by_display_name(params[:display_name])

		@message = Message.new

		@message_recipient = @user

	end

	def welcome

		@page_title = "Welcome"

		if user_signed_in?

			if current_user.onboarded

				redirect_to root_path
			else


			end

		else

			redirect_to root_path
		end


	end

	def setup_user

		if user_signed_in?

			# params.each do |key|

			# 	if Community.exists?(:name => key[0])

			# 	  @community = Community.where(:name => key[0]).first

			# 	  @following = Following.new

			# 	  @following.update(:following_id => @community.id, :follower_id => current_user.id, :active => true)

			# 	  @following.save

			# 	end

			# end

			current_user.update(:onboarded => true)

			current_user.save

		end

		redirect_to root_path

	end

	def update_stripe_account

		account = Stripe::Account.retrieve(current_user.stripe_account_id)

		if user_signed_in?
			@hide_header = true
		end

		if params[:firstName].size > 0
			account.legal_entity.first_name = params[:firstName].upcase
		end

		if params[:lastName].size > 0
			account.legal_entity.last_name = params[:lastName].upcase
		end

		dobDate = params[:dobDate]

		if dobDate.size > 0

			unless dobDate == ""

			dobYear = dobDate[0..3]
			dobMonth = dobDate[5..6]
			dobDay = dobDate[8..10]

			account.legal_entity.dob.day = dobDay
			account.legal_entity.dob.month = dobMonth
			account.legal_entity.dob.year = dobYear

			end

		end

		if params[:last4].size > 0

			account.legal_entity.ssn_last_4 = params[:last4]

		end

		if params[:addressLine1].size > 0

			account.legal_entity.address.line1 = params[:addressLine1].upcase

		end

		if params[:addressLine2].size > 0

			account.legal_entity.address.line2 = params[:addressLine2].upcase

		end

		if params[:city].size > 0

			account.legal_entity.address.city = params[:city].upcase

		end

		if params[:postalCode].size > 0

			account.legal_entity.address.postal_code = params[:postalCode]

		end

		if params[:stateProvince].size > 0

			account.legal_entity.address.state = params[:stateProvince]

		end

		account.save

		redirect_to :back

	end	

	def purchases

		if user_signed_in?
			@hide_header = true
			@page = "mypurchases"
			@page_title = "My Purchases"
		else
			redirect_to root_path
		end

	end


	def bank_accounts

		@page_title = "Settings"

		@page = "account settings"

		if user_signed_in?
			@hide_header = true
		end

		account = current_user.stripe_account_object

		@accounts = account.external_accounts.all(:object => "bank_account", :limit => 5)

      	@defaultaccount = @accounts.find {|x| x.default_for_currency}

	end

	def update_bank_account

		if params[:newdefault]

      		account = Stripe::Account.retrieve(current_user.stripe_account_id)

      		bank_account = account.external_accounts.retrieve(params[:newdefault])

      		bank_account.default_for_currency = true

      		bank_account.save

    	end

    	redirect_to :back

		rescue Stripe::StripeError => e
	  		flash[:error] = e.message
	  		redirect_to :back
		

	end

	def new_bank_account

		if params[:accountHolder] && params[:country] && params[:routingNumber] && params[:accountNumber]
			
			token = Stripe::Token.create(
	    		:bank_account => {
			    :country => params[:country],
			    :account_holder_name => params[:accountHolder],
			    :account_holder_type => "individual",
			    :routing_number => params[:routingNumber],
			    :account_number => params[:accountNumber],
	  			},
			)

			account = Stripe::Account.retrieve(current_user.stripe_account_id)

			bank_account = account.external_accounts.create({:external_account => token.id})

			bank_account.metadata["display_name"] = params[:description]

			bank_account.save

		end

		redirect_to :back

		rescue Stripe::StripeError => e
	  		flash[:error] = e.message
	  		redirect_to :back
	

	end

end
