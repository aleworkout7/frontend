class OrderStatusController < ApplicationController

	def accept
		order_status = OrderStatus.new(order_id: params[:order_id], user_id: current_user.id, status: OrderStatus::ACEPTADO)
		respond_to do |format|
			if order_status.save
				format.html { redirect_to from_clients_orders_path(status: OrderStatus::ACEPTADO.downcase), notice: 'Pedido aceitado.' }
			else
				format.html { redirect_to from_clients_orders_path }
			end
		end
	end

	def canceling
		@order = Order.find(params[:order_id])
		render 'orders/canceling'
	end

	def cancel
		order_status = OrderStatus.new(params[:order_status].permit!)
		order_status.user = current_user
		order_status.status = OrderStatus::CANCELADO

		respond_to do |format|
			if order_status.save

				path = to_shops_orders_path(status: OrderStatus::CANCELADO)
				if order_status.order.canceled_by == "Lojista"
					path = from_clients_orders_path(status: OrderStatus::CANCELADO)
				end

				format.html { redirect_to path, notice: 'Pedido cancelado.' }
			else
				format.html { render :canceling }
			end
		end
	end

	def finish
		order_status = OrderStatus.new(order_id: params[:order_id], user_id: current_user.id, status: OrderStatus::FINALIZADO)

		respond_to do |format|
			if order_status.save
				format.html { redirect_to from_clients_orders_path(status: OrderStatus::FINALIZADO.downcase), notice: 'Pedido finalizado.' }
			else
				format.html { redirect_to from_clients_orders_path }
			end
		end
	end
end
