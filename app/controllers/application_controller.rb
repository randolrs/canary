class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  Stripe.api_key = ENV['STRIPE_SECRET_KEY']

  before_action :check_for_stripe_account, if: :user_signed_in?

  before_action :check_for_billing_information, if: :user_signed_in?

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)

    if user_signed_in?

      if current_user.billing_initiated

        if current_user.display_name

  		    root_path
        
        else

          welcome_path

        end

      else

        billing_information_path

      end



    else

      admin_dashboard_path(resource)

    end


  end


  def after_sign_out_path_for(user)
      request.referrer
  end


  def configure_permitted_parameters

    registration_params = [:email, :password, :is_artist, :is_buyer, :home_city_id, :password, :display_name, :about, :image, :stripe_customer_id, :stripe_account_id, :onboarded]
    devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
    devise_parameter_sanitizer.permit(:sign_in, keys: registration_params)
    devise_parameter_sanitizer.permit(:account_update, keys: registration_params)
  
  end

  
  def check_for_billing_information

      unless current_user.billing_initiated

        #redirect_to billing_information_path

      end

  end



  def check_for_stripe_account
  
    if current_user.is_artist

      unless current_user.stripe_account_id

        account = Stripe::Account.create({:country => "CA", :managed => true})

        current_user.update(:stripe_account_id => account.id, :stripe_secret_key => account.keys.secret)

        account.tos_acceptance.date = Time.now.to_i

        account.tos_acceptance.ip = request.remote_ip

        account.legal_entity.type = "individual"

        account.save


      end

    end

  end


end
