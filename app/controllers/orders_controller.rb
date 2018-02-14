class OrdersController < ApplicationController
	before_action :check_if_user_is_logged_in
	before_action :set_order, only: [:show, :edit, :update, :destroy]

	# GET /orders
	# GET /orders.json
	def index

	end

	def to_shops
		@orders = Order.my_orders(current_user)

		render 'orders/client/index'
	end

	def from_clients
		@orders = Order.clients_orders(current_user)

		render 'orders/seller/index'
	end

	# GET /orders/1
	# GET /orders/1.json
	def show
	end

	# GET /orders/new
	def new
		@order = Order.new
	end

	# GET /orders/1/edit
	def edit
	end

	# POST /orders
	# POST /orders.json
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

	# PATCH/PUT /orders/1
	# PATCH/PUT /orders/1.json
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

	# DELETE /orders/1
	# DELETE /orders/1.json
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
