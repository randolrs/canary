class AffiliatesController < InheritedResources::Base

	def dashboard

		@page_title = "Affiliate Dashboard"

		@hide_return_to_home = true

	end

	def payouts

		@page_title = "Affiliate Payouts"
		

	end


	def settings

		@page_title = "Affiliate Settings"

	end

end

