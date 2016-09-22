class PurchasesController < ApplicationController

	def show
		
    	@purchase = Purchase.find(params[:id])

    	@item_art = @purchase.item_art

    	@page_title = "My Purchases"

  	end

  	def confirmation

  		@purchase = Purchase.find(params[:purchase_id])

  		@customer_id = StripeUserCustomer.where(:user_id => current_user.id).last

  		#unless @purchase.ip_address == request.remote_ip

  			#redirect_to root_path

  		#end


  	end

    def new_card

      token = Stripe::Token.create(
        :card => {
          :number => params[:cardNumber],
          :exp_month => params[:expMonth],
          :exp_year => params[:expYear],
          :cvc => params[:cvc]
        },
      )

      existing_customer = current_user.stripe_customer_object

      if existing_customer

        existing_customer.sources.create({:source => token.id})
        

      else

        new_customer = Stripe::Customer.create(
          :card  => token.id
        )

        stripe_user_customer = StripeUserCustomer.new

        stripe_user_customer.update(:user_id => current_user.id, :stripe_customer_id => new_customer.id)
        
        stripe_user_customer.save

      end

      redirect_to :back

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to :back
    end

    def new_default_card

      if user_signed_in?

        customer = current_user.stripe_customer_object

        customer.default_source = params[:card_id]

        customer.save

        redirect_to :back

      else

        redirect_to root_path

      end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to :back
    end

    def delete_card

      customer = current_user.stripe_customer_object
      
      customer.sources.retrieve(params[:card_id]).delete()

      customer.save

      redirect_to :back

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to :back
    end

end
