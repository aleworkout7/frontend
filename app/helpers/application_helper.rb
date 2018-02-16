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

		cart = extract_cart_from_session

		product = cart.select { |c| c["product_id"].to_i == product.id }

		product.present?
	end

	def amount_items_in_cart
		cart = extract_cart_from_session

		cart.count
	end

	private

	def extract_cart_from_session
		cart = session[:cart]

		cart = [] if cart.blank?

		cart
	end

end
