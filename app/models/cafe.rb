class Cafe < ApplicationRecord
    has_many :bookings
    has_many :users, through: :bookings
    has_many :cafe_foods
    has_many :foods, through: :cafe_foods
    belongs_to :admin
    # accepts_nested_attributes_for :foods

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

    # def foods_attributes=(food_attributes)
    #     food_attributes.values.each do |food_attribute|
    #       food = Food.find_or_create_by(food_attribute)
    #       self.foods << food 
    #     end
    #   end
    
end
