class ContactMailer < ApplicationMailer

	def answer(contact)
		@contact = contact
		mail(to: @contact.email, subject: 'Predios - Contato')
	end

end
