json.extract! excuse, :id, :description, :file, :created_at, :updated_at
json.url excuse_url(excuse, format: :json)
json.file url_for(excuse.file)
