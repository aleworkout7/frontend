class CartController < ApplicationController
	before_action :load_shop

	def index
		@cart = extract_cart_with_products_from_session

		if @cart.blank?
			redirect_to shop_path(@shop)
		end
	end

	def add
		cart = extract_cart_from_session

		cart << params[:product_id]

		update_cart(cart)

		redirect_to action: :index
	end

	def remove
		cart = extract_cart_from_session

		cart.delete(params[:product_id])

		update_cart(cart)

		redirect_to action: :index
	end

	def clear
		update_cart

		redirect_to shop_path(@shop)
	end

	private

	def load_shop
		@shop = Shop.find(params[:id])
	end

	def update_cart(cart = nil)
		cart = cart.uniq if cart.present?

		session[:cart] = cart
	end

	def extract_cart_from_session
		cart = session[:cart]
		cart = [] if cart.blank?

		cart
	end

	def extract_cart_with_products_from_session
		products = []

		extract_cart_from_session.each do |p|
			p = Product.where(id: p).first
			products << p if p.present?
		end

		products
	end

end
