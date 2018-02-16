class OrderStatusController < ApplicationController

	def accept
		respond_to do |format|

			order = Order.find(params[:order_id])
			if order.is_canceled?
				format.html { redirect_to from_clients_orders_path(status: OrderStatus::CANCELADO.downcase), notice: 'Pedido foi cancelado pelo cliente.' }
			else
				order_status = OrderStatus.new(order_id: params[:order_id], user_id: current_user.id, status: OrderStatus::ACEPTADO)
				if order_status.save
					format.html { redirect_to from_clients_orders_path(status: OrderStatus::ACEPTADO.downcase), notice: 'Pedido aceitado.' }
				else
					format.html { redirect_to from_clients_orders_path }
				end
			end

		end
	end

	def finish
		respond_to do |format|

			order = Order.find(params[:order_id])
			if order.is_canceled?
				format.html { redirect_to from_clients_orders_path(status: OrderStatus::CANCELADO.downcase), notice: 'Pedido foi cancelado pelo cliente.' }
			else
				order_status = OrderStatus.new(order_id: params[:order_id], user_id: current_user.id, status: OrderStatus::FINALIZADO)
				if order_status.save
					format.html { redirect_to from_clients_orders_path(status: OrderStatus::FINALIZADO.downcase), notice: 'Pedido finalizado.' }
				else
					format.html { redirect_to from_clients_orders_path }
				end
			end

		end
	end

	def canceling
		@order = Order.find(params[:order_id])
		render 'orders/canceling'
	end

	def cancel
		respond_to do |format|
			order_status = OrderStatus.new(params[:order_status].permit!)
			order_status.user = current_user
			order_status.status = OrderStatus::CANCELADO
			order = order_status.order
			
			if order.is_finished?
				path = decide_what_path(order, OrderStatus::FINALIZADO)
				format.html { redirect_to path, notice: "Pedido foi finalizado pelo Lojista." }

			elsif order.is_canceled?
				path = decide_what_path(order)
				format.html { redirect_to path, notice: "Pedido foi cancelado pelo #{order_status.order.canceled_by}." }

			else
				if order_status.save
					path = decide_what_path(order)
					format.html { redirect_to path, notice: 'Pedido cancelado.' }
				else
					format.html { render :canceling }
				end
			end

		end
	end

	private

	def decide_what_path(order, status = OrderStatus::CANCELADO)
		path = to_shops_orders_path(status: status)
		if order.canceled_by == "Lojista"
			path = from_clients_orders_path(status: status)
		end
	end

end
