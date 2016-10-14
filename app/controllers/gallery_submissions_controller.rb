class GallerySubmissionsController < InheritedResources::Base

	def setup

		@return_home_only = true

		@page_title = "Return to Dashboard"

		if user_signed_in?

			if Gallery.where(:id => params[:gallery_id]).exists?

				@gallery = Gallery.find(params[:gallery_id])

				unless GallerySubmission.where(:user_id => current_user.id, :gallery_id => @gallery.id).exists?

					@gallery_submission = GallerySubmission.new

					@gallery_submission.update(:gallery_id => @gallery.id, :user_id => current_user.id)


				else

					@gallery_submission = GallerySubmission.where(:user_id => current_user.id, :gallery_id => @gallery.id).last
					#redirect_to root_path


				end

				
			else
				
				redirect_to root_path

			end

		else

			redirect_to root_path

		end

	end


	def create_collection

		@return_home_only = true

		@page_title = "Return to Dashboard"

		@gallery_submission = GallerySubmission.find(params[:submission_id])

		@gallery = @gallery_submission.gallery

		if user_signed_in?
			
			unless Collection.where(:user_id => current_user.id, :gallery_submission_id => params[:submission_id]).exists?

				@collection = Collection.new

				@collection.update(:user_id => current_user.id, :gallery_submission_id => params[:submission_id])

				@collection.save

			else

				@collection = Collection.where(:user_id => current_user.id, :gallery_submission_id => params[:submission_id]).last

				CollectionItem.where(:gallery_submission_id => @collection.gallery_submission_id).destroy_all


			end

			params[:item].each do |item|

				if item[1] == "on"

					collection_item = CollectionItem.new
					collection_item.update(:user_id => current_user.id, :item_art_id => item[0], :gallery_submission_id => params[:submission_id], :collection_id => @collection.id)
					collection_item.save

				end

			end

			redirect_to confirm_submission_path(@gallery_submission.id)

		else

			redirect_to root_path

		end
		
	end

	def select_gallery

		@return_home_only = true

		@page_title = "Return to Dashboard"


	end

	def confirm_submission

		if user_signed_in?

			@return_home_only = true

			@page_title = "Return to Dashboard"

			@gallery_submission = GallerySubmission.find(params[:submission_id])

			@gallery = @gallery_submission.gallery

			@collection = Collection.where(:user_id => current_user.id, :gallery_submission_id => params[:submission_id]).last

			unless @collection

				redirect_to root_path

			end

		else

			redirect_to root_path

		end

	end



  private

    def gallery_submission_params
      params.require(:gallery_submission).permit(:user_id, :gallery_id, :collection_id, :additional_description)
    end
end

