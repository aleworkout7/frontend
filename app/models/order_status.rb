class OrderStatus < ActiveRecord::Base
	belongs_to :order
	belongs_to :user

	EN_CURSO = 'EN_CURSO'
	ACEPTADOS = 'ACEPTADOS'
	CANCELADOS = 'CANCELADOS'
	FINALIZADOS = 'FINALIZADOS'

	def self.constants
        [
			EN_CURSO,
			ACEPTADOS,
			CANCELADOS,
			FINALIZADOS
        ]
    end

end
