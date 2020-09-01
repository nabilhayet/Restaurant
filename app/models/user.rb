class User < ApplicationRecord
    has_many :bookings
    has_many :caves, through: :bookings

    
end
