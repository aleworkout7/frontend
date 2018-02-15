class OrdersController < ApplicationController
	before_action :check_if_user_is_logged_in
	before_action :set_order, only: [:show, :edit, :update, :destroy, :show_to_shops, :show_from_clients]

	def index
	end

	def to_shops
		@orders = Order.my_orders(current_user)
		render 'orders/shop/index'
	end

	def show_to_shops
		render 'orders/shop/show'
	end

	def from_clients
		@orders = Order.clients_orders(current_user)
		render 'orders/client/index'
	end

	def show_from_clients
		render 'orders/client/show'
	end

	def show
	end

	def create
		@order = Order.new(order_params)
		@order.user = current_user
		@order.order_statuses << OrderStatus.new(user_id: current_user.id, status: OrderStatus::EN_CURSO)

		respond_to do |format|
			if @order.save
				format.html { redirect_to @order, notice: 'Order was successfully created.' }
				format.json { render :show, status: :created, location: @order }
			else
				format.html { render :new }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @order.update(order_params)
				format.html { redirect_to @order, notice: 'Order was successfully updated.' }
				format.json { render :show, status: :ok, location: @order }
			else
				format.html { render :edit }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@order.destroy
		respond_to do |format|
			format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	def check_if_user_is_logged_in
		return redirect_to root_path unless user_signed_in?
	end

	def set_order
		@order = Order.find(params[:id])
	end

	def order_params
		params.require(:order).permit(:shop_id, :observation, order_items_attributes: [ :product_id, :value, :amount ])
	end
end
