class ChargesController < ApplicationController


	def create
	  # Amount in cents
	  	if params[:itemArtID]
	  		@item_art = ItemArt.find(params[:itemArtID])
		end

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

	  price = params[:amount]

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => price,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )

	purchase = Purchase.create(email: params[:stripeEmail], stripe_card_id: params[:stripeToken], 
    amount: price, description: charge.description, currency: charge.currency,
    stripe_customer_id: customer.id, item_art_id: params[:itemArtID], artist_id: @item_art.user.id)

	if params[:user_id]

		purchase.update(:user_id => params[:user_id])

	end

	redirect_to purchase

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to @item_art
	end


end
