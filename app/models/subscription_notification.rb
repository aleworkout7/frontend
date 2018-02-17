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

			moment = Time.now + 1.month
			unless user.had_subscription_before?
				moment = Time.now + 15.days
			end

			SubscriptionWorker.perform_at(moment - 3.days, user.id)

		elsif self.status == "cancelled"
			user_id = self.external_reference.to_i
			user = User.find(user_id)

			Alejandro.where(email: user.email).first.try(:delete)

			user.had_subscription_before = true
			user.save
		end

	end

	def first_charge_at
		date_at = self.date_created
		user = User.find(self.external_reference)
		if user.present?
			unless user.had_subscription_before?
				date_at += 15.days
			end
		end

		date_at
	end

end
