class CafeFood < ApplicationRecord
  belongs_to :cafe
  belongs_to :food

  validates :cafe_id, uniqueness: { scope: [:food_id],
    message: "You can't add this food to this cafe!" }
end
