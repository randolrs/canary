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

		customer = Stripe::Customer.create(
			:card  => token.id
		)


		plan = Stripe::Subscription.create(
  		:customer => customer.id,
  		:plan => "standard"
		)

		current_user.update(:billing_initiated => true)

		billing_record = StripeBillingUserSubscription.new

		billing_record.update(:stripe_customer_id => customer.id, :user_id => current_user.id, :plan_id => plan.id, :active => true)

		billing_record.save

		if AffiliateSignup.where(:user_id => current_user.id).exists?

			affiliate_signup = AffiliateSignup.where(:user_id => current_user.id).last

			affiliate_commission = AffiliateCommission.new

			commission_amount = 2

			affiliate_commission.update(:user_id => current_user.id, :affiliate_id => affiliate_signup.affiliate_id, :amount => commission_amount, :recurring => false)

		end

		unless current_user.display_name

			redirect_to welcome_path

		else


			root_path

		end

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to :back
	end

end

