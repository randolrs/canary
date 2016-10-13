class GallerySubmissionsController < InheritedResources::Base

	def setup

		if user_signed_in?

			if Gallery.where(:id => params[:gallery_id]).exists?

				@gallery = Gallery.find(params[:gallery_id])

				unless GallerySubmission.where(:user_id => current_user.id, :gallery_id => @gallery.id).exists?

					@gallery_submission = GallerySubmission.new

					@gallery_submission.update(:gallery_id => @gallery.id, :user_id => current_user.id)


				else

					redirect_to root_path


				end

				
			else
				
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

