json.extract! product, :id, :name, :price, :img, :id_shop, :created_at, :updated_at
json.url product_url(product, format: :json)
