class StripeController < ApplicationController

    protect_from_forgery :except => :webhook

    if Rails.env == "production"
  
      Stripe.api_key = ENV['STRIPE_SECRET_KEY_LIVE']

    else

      Stripe.api_key = ENV['STRIPE_SECRET_KEY_TEST']

    end



  def webhook

    # Retrieve the request's body and parse it as JSON

    event_json = JSON.parse(request.body.read)


    if event_json['livemode'] == false

      Stripe.api_key = ENV['STRIPE_SECRET_KEY_TEST']

      event = Stripe::Event.retrieve(event_json["id"])

      stripe_event_id = event_json["id"]

      live = false

    else

      event = Stripe::Event.retrieve(event_json["id"])

      stripe_event_id = event.id

      live = true

    end

    

    if event.type == "invoice.payment_failed"

      stripe_customer_id = event.data.object.customer

      if StripeUserCustomer.where(:stripe_customer_id => stripe_customer_id).exists?
  
        if User.where(:id => stripe_user_customer.user_id).exists?

          user = User.where(:id => stripe_user_customer.user_id).last

          user.update(:billing_active => false)

        end

      end



    elsif event.type == "invoice.payment_succeeded"

      stripe_customer_id = event.data.object.customer

      if StripeUserCustomer.where(:stripe_customer_id => stripe_customer_id).exists?
  
        if User.where(:id => stripe_user_customer.user_id).exists?

          user = User.where(:id => stripe_user_customer.user_id).last

          user.update(:billing_active => true)

        end

      end

    end


    stripe_event = StripeEvent.new

    stripe_event.update(:stripe_id => stripe_event_id, :live => live)

    stripe_event.save

    head :ok

    # rescue
    #   head :conflict
  end

end
