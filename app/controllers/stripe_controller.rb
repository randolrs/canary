class StripeController < ApplicationController

    protect_from_forgery :except => :webhook

    if Rails.env == "production"
  
      Stripe.api_key = ENV['STRIPE_SECRET_KEY_LIVE']

    else

      Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    end



    def webhook

    # Retrieve the request's body and parse it as JSON

    event_json = JSON.parse(request.body.read)


    if event_json['livemode'] == false

      stripe_event_id = event_json["id"]

      stripe_customer_id = event_json["data"]["object"]["customer"]

      live = false

    else

      event = Stripe::Event.retrieve(event_json["id"])

      stripe_event_id = event.id

      stripe_customer_id = event.data.object.customer

      live = true

      if StripeUserCustomer.where(:stripe_customer_id => stripe_customer_id).exists?
        
        stripe_user_customer = StripeUserCustomer.where(:stripe_customer_id => stripe_customer_id).last

        if User.where(:id => stripe_user_customer.user_id).exists?

          user = User.where(:id => stripe_user_customer.user_id).last



          if event.type == "invoice.payment_failed"



          elsif event.type == "invoice.payment_succeeded"



          end




        end


      end


    end

    stripe_event = StripeEvent.new

    stripe_event.update(:stripe_id => stripe_event_id, :stripe_customer_id => stripe_customer_id, :live => live)

    stripe_event.save

    

    #stripe_event.update(:stripe_id => event.id)

    #stripe_event.update(:stripe_id => event_json["data"]["object"]["id"])

    #stripe_event.save

    head :ok
    #Stripe.api_key = ENV['STRIPE_SECRET_KEY_LIVE']

    # rescue
    #   head :conflict
    end

end
