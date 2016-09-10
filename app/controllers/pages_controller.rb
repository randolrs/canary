class PagesController < ApplicationController

	#skip_before_filter :verify_authenticity_token #####****this is a workaround with POSSIBLE SECURITY GAPS####***


	def home

		@page = "home"

		@page_title = "Home"

		if user_signed_in?
			@hide_header = true
		end
		
	end


	def about


	end

	def settings

		@page_title = "Account Settings"

		@page = "settings"

		if user_signed_in?
			@hide_header = true
		end

	end

	def payment_settings

		@page_title = "Account Settings"

		@page = "settings"

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

		@page = "balance"

		@page_title = "My Sales"

		if user_signed_in?
			@hide_header = true
		end

	end

	def balance_payments

		@page = "balance"

		if user_signed_in?
			@hide_header = true
		end

	end

	def views

		@page = "views"


	end

	def messages

		@page = "messages"

		@page_title = "Messages"

		if user_signed_in?
			@hide_header = true
		end


	end

	def my_work

		@page = "work"

		@page_title = "My Portfolio"

		if user_signed_in?
			@hide_header = true
		end

	end

	def profile

		@user = User.find_by_display_name(params[:display_name])

		@message = Message.new

		@message_recipient = @user

	end

	def profile_about

		@user = User.find_by_display_name(params[:display_name])

		@message = Message.new

		@message_recipient = @user

	end

	def welcome

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


	def bank_accounts

		@page_title = "Account Settings"

		@page = "settings"

		if user_signed_in?
			@hide_header = true
		end

		account = Stripe::Account.retrieve(current_user.stripe_account_id)

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
