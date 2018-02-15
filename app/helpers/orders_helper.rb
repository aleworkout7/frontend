module OrdersHelper

	def orders_by_status(orders, status)
		result = orders.select { |o| o.status.status == status } if orders.present? && status.present?

		result || []
	end

	def orders_amount_by_status(orders, status)
		orders = orders_by_status(orders, status)

		orders.try(:count) || 0
	end

	def time_spent_between_last_status(order)
		os = order.status
		statuses = order.order_statuses.order(:id)
		last_status = statuses.select { |s| s.id < os.id }.last

		seconds = (os.created_at - last_status.created_at).to_i
		minutes = (seconds / 60).to_i
		hours = (minutes / 60).to_i
		days = (hours / 24).to_i

		if hours > 24
			"#{days} dia(s)"
		elsif minutes > 60
			"#{hours} hora(s)"
		elsif seconds > 60
			"#{minutes} minuto(s)"
		else
			"#{seconds} segundo(s)"
		end
	end

end
