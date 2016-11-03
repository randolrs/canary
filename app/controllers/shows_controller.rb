class ShowsController < InheritedResources::Base



	def new

		@form_header_prompt = "Enter Show Details"


		@show = Show.new


	end



  private

    def show_params
      params.require(:show).permit(:is_festival, :name, :begin_date, :end_date, :open_to_public, :gallery_id)
    end
end

