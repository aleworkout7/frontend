class Shop < ActiveRecord::Base
	require 'carrierwave/orm/activerecord'
	mount_uploader :image, ImageUploader

	belongs_to :user
	belongs_to :predio
	belongs_to :category
	has_many :products, :dependent => :destroy

	validates :name, :predio_id, presence: true

	def validate
		true
	end

	def self.search(params)
		result = self

		if params[:predio_id].present?
			result = result.where(predio_id: params[:predio_id])
		end

		if params[:search].present?
			result = result	.joins("left join products on products.shop_id = shops.id")
							.joins("left join categories c on c.id = shops.category_id ")
							.where("lower(shops.name) like :search or lower(products.name) like :search or lower(c.name) like :search", { search: "%#{params[:search].downcase}%" })
							.distinct
		end

		result
	end

	def self.published
		result = []
		query = self.joins(:user)

		Alejandro.all.each do |a|
			query.where("users.email = :email", { email: a.email }).each do |r|
				result << r
			end
		end

		result
	end

	def is_published?
		Alejandro.where(email: self.user.email).first.present?
	end

end
