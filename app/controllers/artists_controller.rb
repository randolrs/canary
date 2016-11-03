class ArtistsController < InheritedResources::Base

	def new


		@return_home_only = true

        @page_title = "New Artist"

        @form_header_prompt = "Enter Artist Information"

        @artist = Artist.new

	end

	
	def profile

		@artist = Artist.where(:name => params[:name]).last


	end

	def profile_about

		@artist = Artist.where(:name => params[:name]).last


	end

	def profile_shows

		@artist = Artist.where(:name => params[:name]).last


	end



	def create
    
	    if user_signed_in?

	      @artist = Artist.new(artist_params)

	      if current_user.is_gallery

	      	if current_user.galleries.count == 1
	      		@artist.update(:is_user => false, :gallery_id => current_user.galleries.last.id)
	      	end

	      elsif current_user.is_artist

	      	@artist.update(:user_id => current_user.id, :is_user => true)

	      end


	      respond_to do |format|
	        if @artist.save
	          format.html { redirect_to gallery_artists_path, notice: 'Artist successfully saved.' }
	          format.json { render :show, status: :created, location: @artist }
	        else
	          format.html { render :new }
	          format.json { render json: @artist.errors, status: :unprocessable_entity }
	        end
	      end

	    else

	      redirect_to root_path
	    end

  	end


  private

    def artist_params
      params.require(:artist).permit(:name, :biography, :artist_statement, :birth_year, :nationality, :image)
    end
end

