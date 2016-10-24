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

	  price = (@item_art.price * 100).to_i

	  #platform_fee = (price.to_i * 0.2).to_i

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => price,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd',
	    :destination => @item_art.user.stripe_account_id,
	    :application_fee => platform_fee
	  )

	purchase = Purchase.create(email: params[:stripeEmail], stripe_card_id: params[:stripeToken], 
    amount: price, description: charge.description, currency: charge.currency,
    stripe_customer_id: customer.id, item_art_id: params[:itemArtID], artist_id: @item_art.user.id, ip_address: request.remote_ip)


	if user_signed_in?
		
		if params[:user_id]

			purchase.update(:user_id => params[:user_id])

		end

	end

	redirect_to purchase

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to @item_art
	end

	def create_customer

		if params[:payment_option] == "saved"

			customer = current_user.stripe_customer_object
			
		else

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

		end
	  	
	  	@order = Order.find(params[:order_id])

	  	@order.update(:card_token => customer.id)

	  	redirect_to confirm_order_path(@order.id)


	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to :back
	end



	def start_checkout

		@order = Order.new

		@page_title = "Checkout"

		@item = ItemArt.find(params[:itemID])

		@order_item = OrderItem.new

		if user_signed_in?

			@order.update(:user_id => current_user.id)

		end

		@order.update(:status => "Pending")

		if @order.save

			@order_item.update(:order_id => @order.id, :item_id => @item.id)

			if @order_item.save
				redirect_to start_order_path(@order.id)
			else
				redirect_to :back
			end
		else

			redirect_to :back

		end

	end

	def start_order

		@page_title = "Checkout"

		if Order.exists?(:id => params[:order_id])

			@order = Order.find(params[:order_id])

		end

		if user_signed_in?

			if current_user.stripe_default_card_object

				@user_with_card = true

			end

		end

	end

	def confirm_order

		@page_title = "Checkout"

		@order = Order.find(params[:order_id])

	end

	def confirm_purchase

		if Order.exists?(:id => params[:order_id])

			@order = Order.find(params[:order_id])

			@item_art = @order.order_item.item_art

			stripe_price = (@order.subtotal.to_i*100)

		  	processing_fee = (stripe_price * 0.03).to_i

			charge = Stripe::Charge.create(
			:customer    => @order.card_token,
			:amount      => stripe_price,
			:description => 'Rails Stripe customer',
			:currency    => 'usd',
			:destination => @item_art.user.stripe_account_id,
			:application_fee => processing_fee
			)

			purchase = Purchase.create(amount: stripe_price, description: charge.description, currency: charge.currency,
	    	stripe_customer_id: @order.card_token, item_art_id: @item_art.id, artist_id: @item_art.user.id, order_id: @order.id)


			if user_signed_in?

				unless StripeUserCustomer.exists?(:user_id => current_user.id)

					stripe_user_customer = StripeUserCustomer.new

					stripe_user_customer.update(:user_id => current_user.id, :stripe_customer_id => @order.card_token)
				
					stripe_user_customer.save

				end


				if @order.user_id

					purchase.update(:user_id => @order.user_id)

				end

			end

			redirect_to purchase_confirmation_path(purchase.id)


		else

			redirect_to root_path

		end

	rescue Stripe::RequestError => e
		flash[:error] = e.message
		redirect_to :back

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to :back
	end


end
