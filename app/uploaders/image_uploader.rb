class ImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?  
    storage :fog
    
    include CarrierWave::MiniMagick

    process :resize_to_fit => [400, 400]
    
    def extension_white_list
      %w(jpg jpeg png gif pdf)
    end
    
    def fix_exif_rotation #this is my attempted solution
      manipulate! do |img|
        img.tap(&:auto_orient)
      end
    end
  
    process :fix_exif_rotation
    
    def filename
     "#{secure_token(10)}.#{file.extension}" if original_filename.present?
    end
    
    protected
    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
    end

  
   
  else
    storage :file
  end
  def default_url
    [version_name, "default.jpg"].compact.join('_')
  end
end
