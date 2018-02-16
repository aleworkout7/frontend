class SubscriptionNotification < ActiveRecord::Base
	after_save :synchronize_alejandro

	def synchronize_alejandro

		if self.status == "authorized"
			user_id = self.external_reference.to_i
			user = User.find(user_id)

			alejandro = Alejandro.where(email: user.email).first
			if alejandro.blank?
				Alejandro.create(email: user.email, payment: nil, payment_date: self.date_created, due_date: nil, message: nil, member_id: nil)
			end
			
			alejandro.update_attributes(payment_date: self.date_created)

		elsif self.status == "cancelled"
			user_id = self.external_reference.to_i
			user = User.find(user_id)

			Alejandro.where(email: user.email).first.try(:delete)

		end

	end
end
