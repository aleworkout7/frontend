class SubscriptionWorker
	include Sidekiq::Worker

	def perform(user_id)
		user = User.find(user_id)
		SubscriptionMailer.reminder(user)
	end
end
