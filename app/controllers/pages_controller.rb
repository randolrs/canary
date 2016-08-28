class PagesController < ApplicationController

	#skip_before_filter :verify_authenticity_token #####****this is a workaround with POSSIBLE SECURITY GAPS####***


	def home

		@page = "home"
		
	end


	def about


	end

	def settings

		@page = "settings"

	end


	def sales

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

end
