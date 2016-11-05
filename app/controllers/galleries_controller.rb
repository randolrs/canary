class GalleriesController < InheritedResources::Base

	def submission_format

		@gallery = Gallery.find(params[:id])

		if @gallery.gallery_submission_format

			@gallery_submission_format = @gallery.gallery_submission_format

		else

			@gallery_submission_format = GallerySubmissionFormat.new
		end

	end


	def profile

		@gallery = Gallery.where(:name => params[:name]).last

		@page_title = @gallery.name.possessive + " Profile"

	end

	def profile_shows

		@gallery = Gallery.where(:name => params[:name]).last

		@page_title = @gallery.name.possessive + " Shows"

	end

	def profile_about

		@gallery = Gallery.where(:name => params[:name]).last

		@page_title = "About " + @gallery.name

	end




	def initial_create

		@hide_header = true
		@hide_header_on_all_devices = true

	end



	def create_for_user

		if user_signed_in?


			@gallery = Gallery.new

			@gallery.update(:user_id => current_user.id, :name => params[:galleryName], :city => params[:galleryCity], :state_province => params[:galleryStateProvince])

			@gallery.save

			@gallery_user = GalleryUser.new

			@gallery_user.update(:user_id => current_user.id, :gallery_id => @gallery.id)

			current_user.update(:display_name => params[:name])


			create_stripe_account_for_gallery(@gallery)


			redirect_to schedule_setup_call_path

		else

			redirect_to root_path

		end


	end


	def create_stripe_account_for_gallery(gallery)

		unless gallery.stripe_account_id

			account = Stripe::Account.create({:country => "US", :managed => true})

			gallery.update(:stripe_account_id => account.id)

			account.tos_acceptance.date = Time.now.to_i

			account.tos_acceptance.ip = request.remote_ip

			#account.legal_entity.type = "company"

			account.save

        end

	end


  private

    def gallery_params
      params.require(:gallery).permit(:name, :city, :state_province, :country, :number_of_images, :include_artist_statement, :require_additional_description, :about, :image)
    end
end

