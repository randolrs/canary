class BillingController < ApplicationController

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


		if current_user.stripe_subscription_customer_id

			customer = Stripe::Customer.retrieve(current_user.stripe_subscription_customer_id)

			if customer

				customer.sources.create({:source => token.id})

			else

				customer = Stripe::Customer.create(
					:card  => token.id
				)

			end


			current_user.update(:billing_initiated => true, :billing_active => true)

		else

			customer = Stripe::Customer.create(
      			:description  => "ArtYam Subscription",
      			:card => token.id
    		)

		    if Rails.env == "production"
		  
		      @plan_name = "14freetrial"

		    else

		      @plan_name = "standard"         

		    end

		    plan = Stripe::Subscription.create(
		      :customer => customer.id,
		      :plan => @plan_name
		    )
		    
		    current_user.update(:stripe_subscription_customer_id => customer.id, :billing_initiated => true, :billing_active => true)

		    stripe_user_customer = StripeUserCustomer.new

		    stripe_user_customer.update(:stripe_customer_id => customer.id, :user_id => current_user.id)


		end


		if current_user.billing_information_needed

			stripe_invoice = Stripe::Invoice.list(:limit => 1, :customer => customer.id)
		
			if stripe_invoice

				stripe_invoice.pay

				billing_record = StripeBillingUserSubscription.new

				billing_record.update(:stripe_customer_id => customer.id, :user_id => current_user.id, :active => true)

				billing_record.save

			end

			current_user.update(:billing_initiated => true, :billing_active => true)

		end

		
		if AffiliateSignup.where(:user_id => current_user.id).exists?

			affiliate_signup = AffiliateSignup.where(:user_id => current_user.id).last

			affiliate_commission = AffiliateCommission.new

			commission_amount = 2

			affiliate_commission.update(:user_id => current_user.id, :affiliate_id => affiliate_signup.affiliate_id, :amount => commission_amount, :recurring => false)

		end


		redirect_to root_path


	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to :back
	end

end

