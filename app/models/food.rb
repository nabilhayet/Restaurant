class Food < ApplicationRecord
    has_many :cafe_foods
    has_many :cafes, through: :cafe_foods
    belongs_to :admin 

    validates :name, presence: true
    validates :category, presence: true
    validates :fat, presence: true
    validates :calories, presence: true
   
    validates :fat, numericality: { only_integer: true }
    validates :calories, numericality: { only_integer: true }
   

end
