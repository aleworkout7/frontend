module ApplicationHelper

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
