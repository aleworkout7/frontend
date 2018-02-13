class Shop < ActiveRecord::Base
	require 'carrierwave/orm/activerecord'
	mount_uploader :image, ImageUploader

	has_many :products
	belongs_to :user
	belongs_to :category
	belongs_to :predio

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
			result = result.joins("left join products on products.shop_id = shops.id").where("lower(shops.name) like :search or lower(products.name) like :search", { search: "%#{params[:search].downcase}%" })
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
end
