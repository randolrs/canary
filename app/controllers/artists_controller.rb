class ArtistsController < InheritedResources::Base

	def new


		@return_home_only = true

        @page_title = "New Artist"

        @artist = Artist.new

	end




  private

    def artist_params
      params.require(:artist).permit(:name, :biography, :artist_statement, :birth_year, :nationality, :image)
    end
end

