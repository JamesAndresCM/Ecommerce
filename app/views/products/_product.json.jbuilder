json.extract! product, :id, :name, :pricing, :description, :user_id, :img, :created_at, :updated_at
json.url product_url(product, format: :json)
