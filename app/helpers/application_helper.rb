module ApplicationHelper

	def is_in_cart? product
		return false if product.blank?

		cart = session[:cart]
		cart = [] if cart.blank?
		cart.include? product.id.to_s
	end

end
