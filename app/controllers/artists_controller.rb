class ArtistsController < InheritedResources::Base

  private

    def artist_params
      params.require(:artist).permit(:name, :biography, :artist_statement, :birth_year, :nationality)
    end
end

