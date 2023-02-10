json.extract! event, :id, :name, :date, :point_type, :event_type, :phrase, :created_at, :updated_at
json.url event_url(event, format: :json)
