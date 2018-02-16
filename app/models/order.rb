class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :shop

	has_many :order_items
	accepts_nested_attributes_for :order_items

	has_many :order_statuses
	has_one :status, -> { order id: :desc }, class_name: "OrderStatus", foreign_key: :order_id

	scope :my_orders, -> (user) { includes(:status).where(user_id: user.try(:id)) }
	scope :clients_orders, -> (user) { includes(:status).joins(:shop).where("shops.user_id = :user_id", { user_id: user.try(:id) }) }

	before_save :process_total_value
	def process_total_value
		total = 0

		order_items.each { |i| total += (i.value * i.amount) }

		self.total = total
	end



	def canceled_by
		return "Cliente" if self.user.id == self.status.try(:user).try(:id)

		"Lojista"
	end

	def is_canceled?
		self.status.try(:status) == OrderStatus::CANCELADO
	end

end
