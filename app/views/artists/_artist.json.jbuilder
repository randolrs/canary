json.extract! artist, :id, :name, :biography, :artist_statement, :birth_year, :nationality, :created_at, :updated_at
json.url artist_url(artist, format: :json)