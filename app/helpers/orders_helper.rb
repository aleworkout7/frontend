module OrdersHelper

	def orders_by_status(orders, status)
		orders.select { |o| o.status.status == status } if orders.present? && status.present?
	end

	def orders_amount_by_status(orders, status)
		orders = orders_by_status(orders, status)

		orders.try(:count) || 0
	end

end
