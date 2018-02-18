class Predio < ActiveRecord::Base
	has_many :shops
	belongs_to :housing_set

	scope :highlighteds, -> { where(is_highlight: true).distinct }

	mount_uploader :image, ImageUploader

	def self.search(search)
		result = self

		if search.present?
			result = result	.joins("left join housing_sets hs on hs.id = predios.housing_set_id")
							.joins("left join districts d on d.id = hs.district_id")
							.joins("left join cities c on c.id = d.city_id")
							.where("lower(predios.name) like :search or lower(hs.name) like :search or lower(d.name) like :search or lower(c.name) like :search", { search: "%#{search.downcase}%" })
							.distinct
		end

		result
	end
end
