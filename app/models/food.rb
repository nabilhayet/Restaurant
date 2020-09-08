class Food < ApplicationRecord
    has_many :cafe_foods
    has_many :cafes, through: :cafe_foods

    validates :name, presence: true
    validates :category, presence: true
    validates :fat, presence: true
    validates :calories, presence: true
    validates :price, presence: true
    validates :fat, numericality: { only_integer: true }
    validates :calories, numericality: { only_integer: true }
    validates :price, numericality: { only_integer: true }

end
