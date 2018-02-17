class SubscriptionWorker
	include Sidekiq::Worker

	def perform(user)
		SubscriptionMailer.reminder(user)
	end
end
