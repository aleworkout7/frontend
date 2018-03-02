class StatusWorker
	include Sidekiq::Worker

	def perform(order_status_id, client_id, seller_id)
		order_status = OrderStatus.find(order_status_id)

		client = nil
		seller = nil

		client = User.find(client_id) unless client_id.blank?
		seller = User.find(seller_id) unless seller_id.blank?

		if order_status.status == OrderStatus::EN_CURSO && client.present?
			# Client create an order
			OrderStatusMailer.buy(order_status, client).deliver_later

		elsif order_status.status == OrderStatus::FINALIZADO && seller.present?
			# Seller finish an order
			OrderStatusMailer.delivered(order_status, seller).deliver_later

		end

		# Check for who will receive
		if order_status.user.id == seller.try(:id)
			OrderStatusMailer.new_status_for_seller(order_status, seller).deliver_later
		elsif client.present?
			OrderStatusMailer.new_status_for_client(order_status, client).deliver_later
		end

	end
end
