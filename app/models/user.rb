class User < ApplicationRecord
    has_secure_password 
    has_many :bookings
    has_many :cafes, through: :bookings
    accepts_nested_attributes_for :bookings

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :password, presence: true
    validates(:password, { :length => { :in => 6..20 } })
    validates :contact, presence: true
    validates :contact, length: { is: 10 }
    validates :contact, numericality: { only_integer: true }

    def full_name 
        self.first_name + " " +self.last_name 
    end 
end
