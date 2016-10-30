class SubscriptionsController < ApplicationController

	def initiate_subscription
		
    	customer = Stripe::Customer.create(
      :description  => "ArtYam Subscription"
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
    
    current_user.update(:stripe_subscription_customer_id => customer.id)

    stripe_user_customer = StripeUserCustomer.new

    stripe_user_customer.update(:stripe_customer_id => customer.id, :user_id => current_user.id)


  end

end
