class PagesController < ApplicationController

	#skip_before_filter :verify_authenticity_token #####****this is a workaround with POSSIBLE SECURITY GAPS####***


	def home

		@page = "work"
		
	end


	def about


	end

	def settings

		@page = "settings"

	end

	def payment_settings

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

		else

			redirect_to root_path

		end

	end


	def sales

		@page = "balance"

	end

	def balance_payments

		@page = "balance"

	end

	def views

		@page = "views"


	end

	def messages

		@page = "messages"

	end

	def my_work

		@page = "work"

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

		if params[:firstName]
			account.legal_entity.first_name = params[:firstName].upcase
		end

		if params[:lastName]
			account.legal_entity.last_name = params[:lastName].upcase
		end

		dobDate = params[:dobDate]

		if dobDate

			unless dobDate == ""

			dobYear = dobDate[0..3]
			dobMonth = dobDate[5..6]
			dobDay = dobDate[8..10]

			account.legal_entity.dob.day = dobDay
			account.legal_entity.dob.month = dobMonth
			account.legal_entity.dob.year = dobYear

			end

		end

		account.save

		redirect_to :back

	end	

	def bank_accounts


	end

end
