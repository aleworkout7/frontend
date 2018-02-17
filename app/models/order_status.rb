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

		StatusWorker.perform_async(self, client, seller)

		return true
	end

end
