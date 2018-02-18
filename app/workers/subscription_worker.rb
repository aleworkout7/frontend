class SubscriptionWorker
	include Sidekiq::Worker

	def perform(user_id)
		puts "Perform Reminder in SubscriptionWorker: #{user_id}"
		user = User.find(user_id)
		SubscriptionMailer.reminder(user).deliver_now
	end
end
