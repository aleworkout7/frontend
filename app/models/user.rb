class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

	has_many :shops
	has_many :pagos
	has_many :orders
	has_many :addresses, :dependent => :destroy
	has_one :address, -> { order id: :desc }


	def is_my_shop? shop
		return false if shop.blank?

		self.id == shop.user_id
	end

	def has_subscription?
		Alejandro.where(email: self.email).first.present?
	end

	def valid_register?
		address = self.address

		if address.blank?
			return false
		elsif address.number.blank? || address.block.blank? || address.floor.blank? || self.name.blank? || self.phone.blank?
			return false
		end

		true
	end

end
