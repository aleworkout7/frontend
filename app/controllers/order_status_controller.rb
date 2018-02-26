class OrderStatusController < ApplicationController

	def accept
		respond_to do |format|

			order = Order.find(params[:order_id])
			if order.is_canceled?
				format.html { redirect_to from_clients_orders_path(status: OrderStatus::CANCELADO.downcase), notice: 'Pedido foi cancelado pelo cliente.' }
			else
				order_status = OrderStatus.new(order_id: params[:order_id], user_id: current_user.id, status: OrderStatus::ACEITO)
				if order_status.save
					format.html { redirect_to from_clients_orders_path(status: OrderStatus::ACEITO.downcase), notice: 'Pedido aceito.' }
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
					format.html { redirect_to from_clients_orders_path(status: OrderStatus::FINALIZADO.downcase), notice: 'Pedido entregue.' }
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


			if params[:from_status] != order.status.status
				path = decide_what_path(order, params[:from_status])
				msg = "O status do pedido foi alterado antes de cancelar."

				if order.is_client? current_user
					if order.status.status == OrderStatus::FINALIZADO
						msg = "O pedido ja foi entregue pelo vendedor"
					elsif order.status.status == OrderStatus::CANCELADO
						msg = "O pedido foi cancelado pelo vendedor"
					else
						msg = "O pedido ja foi aceito pelo vendedor"
					end
				end

				format.html { redirect_to path, notice: msg }

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
		unless order.is_client? current_user
			path = from_clients_orders_path(status: status)
		end

		path
	end

end
