class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :shop

	has_many :order_items
	has_many :order_status

	accepts_nested_attributes_for :order_items
end
