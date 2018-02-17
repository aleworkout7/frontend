class OrderStatus < ActiveRecord::Base
	belongs_to :order
	belongs_to :user

	after_save :notify_users

	EN_CURSO = 'EN_CURSO'
	ACEPTADO = 'ACEPTADO'
	CANCELADO = 'CANCELADO'
	FINALIZADO = 'FINALIZADO'

	def self.constants
        [
			EN_CURSO,
			ACEPTADO,
			CANCELADO,
			FINALIZADO
        ]
    end

	def notify_users
		order_status = self
		order = order_status.order
		client = order.user
		seller = order.shop.user

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

		# StatusWorker.perform_async(self, client, seller)

		return true
	end

end
