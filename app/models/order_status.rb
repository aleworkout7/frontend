class OrderStatus < ActiveRecord::Base
	belongs_to :order
	belongs_to :user

	# after_save :notify_users

	EN_CURSO = 'EM_ANDAMENTO'
	ACEPTADO = 'ACEITO'
	CANCELADO = 'CANCELADO'
	FINALIZADO = 'ENTREGUE'

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
		client_id = order.user_id
		seller_id = order.try(:shop).try(:user_id)

		StatusWorker.perform_async(self.id, client_id, seller_id)

		return true
	end

end
