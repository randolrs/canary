class BillingController < InheritedResources::Base

	def billing_information

		@hide_header = true
		@hide_header_on_all_devices = true
		

	end

	def initiate

		token = Stripe::Token.create(
			:card => {
				:number => params[:cardNumber],
				:exp_month => params[:expMonth],
				:exp_year => params[:expYear],
				:cvc => params[:cvc]
			},
		)

		customer = Stripe::Customer.create(
			:card  => token.id
		)


		Stripe::Subscription.create(
  		:customer => customer.id,
  		:plan => "beta"
		)


		redirect_to welcome_path

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to @item_art
	end

end

