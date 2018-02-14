class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :shop

	has_many :order_items
	accepts_nested_attributes_for :order_items

	has_many :order_statuses
	has_one :status, -> { order id: :desc }, class_name: "OrderStatus", foreign_key: :order_id

	before_save :process_total_value

	def process_total_value
		total = 0
		order_items.each do |i|
			total += i.value
		end

		self.total = total
	end
end
