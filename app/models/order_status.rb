class OrderStatus < ActiveRecord::Base
	belongs_to :order
	belongs_to :user

	EN_CURSO = 'EN_CURSO'
	ACEPTADOS = 'ACEPTADOS'
	CANCELADOS = 'CANCELADOS'
	FINALIZADOS = 'FINALIZADOS'
end
