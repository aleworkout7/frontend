class Member < ActiveRecord::Base
    has_many :alejandros
    has_many :pagos
end
