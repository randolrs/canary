json.extract! gallery, :id, :name, :city, :state_province, :country, :created_at, :updated_at
json.url gallery_url(gallery, format: :json)