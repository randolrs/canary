class GalleriesController < InheritedResources::Base

	def submission_format

		@gallery = Gallery.find(params[:id])

		if @gallery.gallery_submission_format

			@gallery_submission_format = @gallery.gallery_submission_format

		else

			@gallery_submission_format = GallerySubmissionFormat.new
		end

	end


  private

    def gallery_params
      params.require(:gallery).permit(:name, :city, :state_province, :country, :number_of_images, :include_artist_statement, :require_additional_description)
    end
end

