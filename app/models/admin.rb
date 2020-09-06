class Admin < ApplicationRecord
    has_secure_password 
    has_many :cafes 
    accepts_nested_attributes_for :cafes 

    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :password, presence: true
    validates(:password, { :length => { :in => 6..20 } })
end
