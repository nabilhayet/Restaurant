class User < ApplicationRecord
    has_secure_password 
    has_many :bookings
    has_many :cafes, through: :bookings
    accepts_nested_attributes_for :bookings

    validates :name, presence: true
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :username, length: { minimum: 6 }
    validates :password, presence: true
    validates(:password, { :length => { :in => 6..20 } })
    validates :contact, presence: true
    validates :contact, length: { is: 10 }
    validates :contact, numericality: { only_integer: true }
end
