class Address < ActiveRecord::Base
  belongs_to :predio
  belongs_to :user
end
