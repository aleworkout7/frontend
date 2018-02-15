class OrderStatusMailer < ApplicationMailer

	def new_status(order_status, user)
		@user = user
		@status = order_status
		mail(to: @user.email, subject: 'Predios - Pedido atualizado')
	end

end
