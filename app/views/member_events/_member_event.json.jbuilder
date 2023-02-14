json.extract! member_event, :id, :event_id, :member_id, :approved_status, :approve_date, :approve_by, :created_at, :updated_at
json.url member_event_url(member_event, format: :json)
