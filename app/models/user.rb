class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	has_many :shops
	has_many :pagos

	has_many :addresses
	has_one :address, -> { order id: :desc }

end
