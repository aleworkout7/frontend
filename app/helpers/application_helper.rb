module ApplicationHelper

	def format_date date
		date.strftime("%d/%m/%Y") if date.present?
	end

	def format_datetime date
		date.strftime("%d/%m/%Y %H:%M") if date.present?
	end

	def format_currency value
		number_to_currency value, unit: "$ ", separator: ",", delimiter: "."  if value.present?
	end

	def is_in_cart? product
		return false if product.blank?

		cart = extract_cart_from_session product.shop

		product = cart.select { |c| c["product_id"].to_i == product.id }

		product.present?
	end

	def amount_items_in_cart shop
		cart = extract_cart_from_session shop

		cart.count
	end

	private

	def extract_cart_from_session shop
		shop_id = session[:cart_shop_id]
		
		session[:cart] = nil if shop_id != shop.id

		cart = session[:cart]

		cart = [] if cart.blank?

		cart
	end

end
