class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  #Stripe.api_key = ENV["stripe_api_key"]

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)

    	if current_user.onboarded

  			request.referrer
  			
  		else

  			welcome_path

  		end

  end

  def after_sign_out_path_for(user)
      request.referrer
  end


  def configure_permitted_parameters

    registration_params = [:email, :password, :is_artist, :is_buyer, :home_city_id, :password, :display_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
    devise_parameter_sanitizer.permit(:sign_in, keys: registration_params)
    devise_parameter_sanitizer.permit(:account_update, keys: registration_params)
  
  end


end
