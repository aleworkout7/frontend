class OrderStatusMailer < ApplicationMailer

	def buy(order_status, user)
		@user = user
		@status = order_status
		mail(to: @user.email, subject: 'Predios - Pedido criado')
	end
	
	def buy2(order_status, user)
		@user = user
		@status = order_status
		mail(to: @user.email, subject: 'Predios - Novo pedido')
	end

	def delivered(order_status, user)
		@user = user
		@status = order_status
		mail(to: @user.email, subject: 'Predios - Pedido entregue')
	end

	def new_status_for_client(order_status, user)
		@user = user
		@status = order_status
		mail(to: @user.email, subject: 'Predios - Pedido atualizado')
	end

	def new_status_for_seller(order_status, user)
		@user = user
		@status = order_status
		mail(to: @user.email, subject: 'Predios - Pedido atualizado')
	end

end
