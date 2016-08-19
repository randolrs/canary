class PagesController < ApplicationController

	def home


	end


	def about


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

end
