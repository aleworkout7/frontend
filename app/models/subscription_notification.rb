class SubscriptionNotification < ActiveRecord::Base
	after_save :synchronize_alejandro

	def synchronize_alejandro

		if self.status == "authorized"
			user_id = self.external_reference.to_i
			user = User.find(user_id)

			alejandro = Alejandro.find_or_create_by(email: user.email)
			if alejandro.present?
				alejandro.update_attributes(payment_date: self.date_created)
			end

		elsif self.status == "cancelled"
			user_id = self.external_reference.to_i
			user = User.find(user_id)

			Alejandro.where(email: user.email).first.try(:delete)

		end

	end
end
