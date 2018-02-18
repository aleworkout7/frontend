class SubscriptionMailer < ApplicationMailer

	def reminder(user)
		@user = user
		mail(to: @user.email, subject: 'Predios - Lembrete Assinatura')
	end

end
