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

    def cafe_name=(name)
        self.cafes = Cafe.find_or_create_by(name: name)
      end
    
      def cafe_name
         self.cafes.last ? self.cafes.last.name : nil
      end

end
