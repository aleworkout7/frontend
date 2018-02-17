class StatusWorker
	include Sidekiq::Worker

	def perform(order_status_id, client_id, seller_id)
		order_status = OrderStatus.find(order_status_id)
		client = User.find(client_id)
		seller = User.find(seller_id)

		if order_status.status == EN_CURSO
			# Client create an order
			OrderStatusMailer.buy(order_status, client).deliver_later

		elsif order_status.status == FINALIZADO
			# Seller finish an order
			OrderStatusMailer.delivered(order_status, seller).deliver_later

		end

		# Check for who will receive
		if order_status.user.id == seller.id
			OrderStatusMailer.new_status_for_seller(order_status, client).deliver_later
		else
			OrderStatusMailer.new_status_for_client(order_status, seller).deliver_later
		end

	end
end
