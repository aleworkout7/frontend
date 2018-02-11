class Pago < ActiveRecord::Base
    belongs_to :member
    belongs_to :user
    belongs_to :banco
    belongs_to :account
    
    mount_uploader :image, ImageUploader
    
    validates :amount, :predio_name, :predio_address, presence: true
end
