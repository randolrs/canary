json.extract! gallery_submission, :id, :user_id, :gallery_id, :collection_id, :additional_description, :created_at, :updated_at
json.url gallery_submission_url(gallery_submission, format: :json)