class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

	has_many :shops
	has_many :pagos

	has_many :addresses
	has_one :address, -> { order id: :desc }


	def is_my_shop? shop
		return false if shop.blank?

		self.id == shop.user_id
	end

	def has_subscription?
		Alejandro.where(email: self.email).first.present?
	end

	def start_date_for_subscription
		start_date = Time.now
		unless self.had_subscription_before?
			start_date += 15.days
		end

		start_date.strftime("%Y-%m-%d")
	end

end
