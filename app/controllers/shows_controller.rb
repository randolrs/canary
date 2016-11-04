class ShowsController < InheritedResources::Base



	def new

		@form_header_prompt = "Enter Show Details"


		@show = Show.new

		@page_title = "New Work"

		@return_home_only = true


	end

	def profile

		@show = Show.where(:name => params[:name]).last

		@page_title = @show.name
		
	end



	def create
    
	    if user_signed_in?

	      @show = Show.new(show_params)


	      if params[:begin_date]

	      	@show.update(:begin_date => params[:begin_date])

	      end



	      if params[:end_date]

	      	@show.update(:end_date => params[:end_date])

	      end

	      respond_to do |format|
	        if @show.save
	          format.html { redirect_to dashboard_shows_path, notice: 'Show successfully created.' }
	          format.json { render :show, status: :created, location: @show }
	        else
	          format.html { render :new }
	          format.json { render json: @show.errors, status: :unprocessable_entity }
	        end
	      end

	    else

	      redirect_to root_path
	    end
  end





  private

    def show_params
      params.require(:show).permit(:is_festival, :name, :begin_date, :end_date, :open_to_public, :gallery_id, :artist_id)
    end
end

