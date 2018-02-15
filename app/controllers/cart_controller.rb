class CartController < ApplicationController
	before_action :check_if_user_is_logged_in
	before_action :load_shop
	before_action :check_if_user_is_seller_of_this_shop

	def index
		@cart = extract_cart_with_products_from_session

		redirect_to shop_path(@shop) if @cart.blank?
	end

	def add
		cart = extract_cart_from_session

		product = cart.select { |c| c["product_id"].to_i == params[:product_id].try(:to_i) }

		cart << { product_id: params[:product_id], amount: 1 } if product.blank?

		update_cart(cart)

		redirect_to action: :index
	end

	def remove
		cart = extract_cart_from_session

		cart.delete_if { |c| c["product_id"].to_i == params[:product_id].try(:to_i) }

		update_cart(cart)

		redirect_to action: :index
	end

	def clear
		update_cart

		redirect_to shop_path(@shop)
	end

	def update_amount
		product_id = params[:product_id]

		amount = params[:amount]

		cart = extract_cart_from_session

		cart.each { |c| c["amount"] = amount if c["product_id"] == product_id }

		update_cart(cart)

		render nothing: true
	end

	private

	def check_if_user_is_logged_in
		return redirect_to root_path unless user_signed_in?
	end

	def check_if_user_is_seller_of_this_shop
		if user_signed_in?
			if current_user.id == @shop.user_id
				return redirect_to root_path
			end
		end
	end

	def load_shop
		@shop = Shop.find(params[:id])
	end

	def update_cart(cart = nil)
		session[:cart] = cart
	end

	def extract_cart_from_session
		cart = session[:cart]

		cart = [] if cart.blank?

		cart
	end

	def extract_cart_with_products_from_session
		result = []

		extract_cart_from_session.each do |p|
			# Return an order list with product and amount
			# orders << Order.new(p, amount)
			product = Product.where(id: p["product_id"]).first
			result << { product: product, amount: p["amount"] } if product.present?
		end

		result
	end

end
