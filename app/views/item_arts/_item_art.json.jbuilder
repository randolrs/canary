json.extract! item_art, :id, :user_id, :description, :name, :height, :width, :length, :venue_id, :price, :search_code, :created_at, :updated_at
json.url item_art_url(item_art, format: :json)