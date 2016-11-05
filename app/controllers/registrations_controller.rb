class RegistrationsController < Devise::RegistrationsController

	#protected

	prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  	prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  	prepend_before_action :set_minimum_password_length, only: [:new, :edit]

  # GET /resource/sign_up
  def new
    @hide_header = true
    @hide_footer = true
    @hide_header_on_all_devices = true
    build_resource({})
    yield resource if block_given?
    respond_with resource
  end

  # POST /resource
  def create
    
    build_resource(sign_up_params)

    resource.save

    if params[:purchase_id]

        if Purchase.exists?(:id => params[:purchase_id])

          @purchase = Purchase.find(params[:purchase_id])

          @purchase.update(:user_id => resource.id)

        end

    end

    if params[:is_artist]

        resource.update(:is_artist => true)

        resource.save

    end

    if params[:is_affiliate]

        my_referral_code = (SecureRandom.hex(2)).downcase

        resource.update(:is_affiliate => true, :my_referral_code => my_referral_code)

        resource.save

    end


    yield resource if block_given?
    
    if resource.persisted?

      if resource.active_for_authentication?
        #UserMailer.welcome_email(resource).deliver_later

        if params[:is_artist] or resource.is_gallery

          @trial_end_date = Time.now + 14.days

          resource.update(:trial_end_date => @trial_end_date)
          
          #redirect_to initiate_trial_subscription_path and return

          if AffiliateReferral.where(:ip_address => request.remote_ip).exists?

            affiliate_referral = AffiliateReferral.where(:ip_address => request.remote_ip).first

            resource.update(:affiliate_id => affiliate_referral.affiliate_id)
            
            affiliate_signup = AffiliateSignup.new

            affiliate_signup.update(:user_id => resource.id, :affiliate_id => affiliate_referral.affiliate_id, :affiliate_referral_id => affiliate_referral.id)
            
            affiliate_signup.save

          end



        end




        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    render :edit
  end


  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.

  def update

  	if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
    	params[:user].delete(:password)
    	params[:user].delete(:password_confirmation)
	   end

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  def translation_scope
    'devise.registrations'
  end

	def update_resource(resource, params)
		resource.update_without_password(params)
	end

end
