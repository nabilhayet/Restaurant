class Cafe < ApplicationRecord
    has_many :bookings
    has_many :users, through: :bookings
    belongs_to :admin

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :street, presence: true
    validates :street, uniqueness: true
    validates :city, presence: true
    validates :state, presence: true
    validates :state, length: { is: 2 }
    validates :zipcode, presence: true
    validates :zipcode, numericality: { only_integer: true }
    validates :zipcode, length: { is: 5 }
    
end
