class PaymentNotification < ActiveRecord::Base
	after_save :synchronize_alejandro

	def synchronize_alejandro

		if self.status == "approved"
			user_id = self.external_reference.to_i
			user = User.find(user_id)

 			alejandro = Alejandro.find_or_create_by(email: user.email)
			if alejandro.present?
				alejandro.update_attributes(payment: self.total_paid_amount, payment_date: self.date_created, due_date: nil, message: nil, member_id: nil)
			end

			moment = Time.now + 1.month - 3.days
			SubscriptionWorker.perform_at(moment, user.id)

		else
			user_id = self.external_reference.to_i
			user = User.find(user_id)

			Alejandro.where(email: user.email).first.try(:delete)

			user.had_subscription_before = true
			user.save
		end

	end
end
