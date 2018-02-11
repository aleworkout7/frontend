class Product < ActiveRecord::Base
    belongs_to :shop
    mount_uploader :image, ImageUploader
    
    
    validates :name, :shop_id, presence: true, length: { maximum: 30 }
    
    
    
    def validate
        true
    end
end
