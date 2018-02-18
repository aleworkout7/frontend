class SubscriptionMailer < ApplicationMailer

	def reminder(user)
		puts "Reminder in SubscriptionMailer: #{user.try(:email)}"
		@user = user
		mail(to: @user.email, subject: 'Predios - Lembrete Assinatura')
	end

end
