class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  if Rails.env == "production"
  
    Stripe.api_key = ENV['STRIPE_SECRET_KEY_LIVE']

  else

    Stripe.api_key = ENV['STRIPE_SECRET_KEY_TEST']

  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :check_for_affiliate

  before_action :check_for_stripe_account, if: :user_signed_in?

  before_action :check_if_trial_expired, if: :user_signed_in?

  skip_before_filter :check_if_trial_expired, :only => [:billing_information, :initiate]

  #skip_before_filter :check_if_trial_expired, only: :billing_initialize

  protect_from_forgery with: :exception


  def after_sign_in_path_for(resource)

    if user_signed_in?

      if current_user.is_affiliate

        affiliate_dashboard_path

      elsif current_user.is_gallery

        unless current_user.billing_information_needed or Time.now > current_user.trial_end_date

          if current_user.galleries.count == 0

            gallery_inital_create_path

          else

            root_path

          end

        else

          billing_information_path

        end


      elsif current_user.artist

      end


      # if current_user.is_gallery

      #   root_path

      # end


      # if current_user.is_affiliate

      #   affiliate_dashboard_path

      # end






      # if current_user.is_artist

      #   unless current_user.billing_information_needed or Time.now > current_user.trial_end_date

      #     if current_user.display_name

      #       root_path
          
      #     else

      #       welcome_path

      #     end

      #   else

      #     billing_information_path

      #   end

      # end


      # if current_user.is_gallery

      #   root_path

      # end


      # if current_user.is_affiliate

      #   affiliate_dashboard_path

      # end



    else

      admin_dashboard_path(resource)

    end


  end


  def after_sign_out_path_for(user)
      root_path
  end




  def check_if_trial_expired

    if current_user.billing_information_needed or (Time.now > current_user.trial_end_date && !current_user.billing_active)

     
      redirect_to billing_information_path

    end

  end





  def check_for_affiliate

    if params[:affid]

      affiliateReferral = AffiliateReferral.new

      # allows repeats if User.where(:my_referral_code => params[:affid]).exists?

      if User.where(:my_referral_code => params[:affid]).exists? && !AffiliateReferral.where(:ip_address => request.remote_ip).exists?


        affiliateReferral.update(:ip_address => request.remote_ip, :referral_url => request.referrer, :affiliate_id => User.where(:my_referral_code => params[:affid]).last.id)

        affiliateReferral.save

        session[:affiliate_id] = params[:affid]

      end

    end

  end


  def configure_permitted_parameters

    registration_params = [:email, :password, :is_artist, :is_buyer, :home_city_id, :password, :display_name, :about, :image, :stripe_customer_id, :stripe_account_id, :onboarded, :is_artist, :is_gallery]
    devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
    devise_parameter_sanitizer.permit(:sign_in, keys: registration_params)
    devise_parameter_sanitizer.permit(:account_update, keys: registration_params)
  
  end



  def check_for_stripe_account
  
    if current_user.is_artist

      unless current_user.stripe_account_id

        account = Stripe::Account.create({:country => "US", :managed => true})

        current_user.update(:stripe_account_id => account.id, :stripe_secret_key => account.keys.secret)

        account.tos_acceptance.date = Time.now.to_i

        account.tos_acceptance.ip = request.remote_ip

        account.legal_entity.type = "individual"

        account.save

      end

    elsif current_user.is_gallery

      @my_gallery = current_user.galleries.last

      if @my_gallery

        unless @my_gallery.stripe_account_id

          account = Stripe::Account.create({:country => "US", :managed => true})

          @my_gallery.update(:stripe_account_id => account.id)

          account.tos_acceptance.date = Time.now.to_i

          account.tos_acceptance.ip = request.remote_ip

          account.legal_entity.type = "company"

          account.save


        end

      end

    end
      

  end


end
