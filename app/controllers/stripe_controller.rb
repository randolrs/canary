class StripeController < ApplicationController

    protect_from_forgery :except => :webhook

    def webhook
  

    # Retrieve the request's body and parse it as JSON

    event_json = JSON.parse(request.body.read)

    event = Stripe::Event.retrieve(event_json["id"])

    StripeEvent.create(id: event.id)

    if event.type == "invoice.payment_failed"

      if StripeCustomer.where(:stripe_customer_id => event.data.object.customer).exists?

        stripe_customer = StripeCustomer.where(:stripe_customer_id => event.data.object.customer).last

        if User.where(stripe_customer.user_id).exists?
          
          user = User.find(stripe_customer.user_id)

          user.update(:billing_active => false)

        end

      end

    end

    #stripe_event.update(:stripe_id => event.id)

    #stripe_event.update(:stripe_id => event_json["data"]["object"]["id"])

    #stripe_event.save

    head :ok


    rescue
      head :internal_server_error
    end

end
