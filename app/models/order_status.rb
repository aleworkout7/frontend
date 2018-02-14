class OrderStatus < ActiveRecord::Base
	belongs_to :order
	belongs_to :user_id
end
