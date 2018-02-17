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
		order = self.order
		client = order.user
		seller = order.shop.user

		if self.status == EN_CURSO
			# Client create an order
			OrderStatusMailer.buy(self, client).deliver_later

		elsif self.status == FINALIZADO
			# Seller finish an order
			OrderStatusMailer.delivered(self, seller).deliver_later

		end

		# Check for who will receive
		if self.user.id == seller.id
			OrderStatusMailer.new_status_for_seller(self, client).deliver_later
		else
			OrderStatusMailer.new_status_for_client(self, seller).deliver_later
		end

		return true
	end

end
