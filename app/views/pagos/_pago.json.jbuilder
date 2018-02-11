json.extract! pago, :id, :user_id, :member_id, :payment_date, :amount, :message, :checked, :predio_name, :predio_address, :created_at, :updated_at
json.url pago_url(pago, format: :json)
