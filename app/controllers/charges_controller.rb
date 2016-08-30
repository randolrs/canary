class ChargesController < ApplicationController


	def create
	  # Amount in cents
	  	if params[:itemArtID]
	  		@item_art = ItemArt.find(params[:itemArtID])
		end

	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :card  => params[:stripeToken]
	  )


	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => (params[:amount]*100).to_i,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )

	purchase = Purchase.create(email: params[:stripeEmail], stripe_card_id: params[:stripeToken], 
    amount: params[:amount], description: charge.description, currency: charge.currency,
    stripe_customer_id: customer.id, item_art_id: params[:itemArtID], artist_id: @item_art.user.id)

	if params[:user_id]

		purchase.update(:user_id => params[:user_id])

	end

	redirect_to purchase

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end


end
