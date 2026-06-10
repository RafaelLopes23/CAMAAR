json.extract! response, :id, :form_id, :user_id, :content, :created_at, :updated_at
json.url response_url(response, format: :json)
