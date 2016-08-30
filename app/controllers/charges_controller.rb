class ChargesController < ApplicationController


	def create
	  # Amount in cents
	  @amount = 500

	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :card  => params[:stripeToken]
	  )


	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => (params[:amount]).to_i,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )

	purchase = Purchase.create(user_id: current_user.id, email: params[:stripeEmail], stripe_card_id: params[:stripeToken], 
    amount: params[:amount], description: charge.description, currency: charge.currency,
    stripe_customer_id: customer.id, item_art_id: params[:itemArtID])

	redirect_to purchase

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end


end
