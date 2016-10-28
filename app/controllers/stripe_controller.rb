class StripeController < ApplicationController

    protect_from_forgery :except => :webhook

    def webhook
  

    # Retrieve the request's body and parse it as JSON
    event_json = JSON.parse(request.body.read)

    # validation for live mode event = Stripe::Event.retrieve(event_json["id"])

    stripe_event = StripeEvent.new

    #stripe_event.update(:stripe_id => event.id)

    stripe_event.update(:stripe_id => "test_21")

    stripe_event.save

    head :ok


    rescue Stripe::CardError => e
      head :internal_server_error
    end

end
