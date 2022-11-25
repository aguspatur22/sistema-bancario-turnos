json.extract! cliente, :id, :email, :password, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
