class CafeFood < ApplicationRecord
  belongs_to :cafe
  belongs_to :food
end
