class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :cafe

  validates :date, presence: true
  validates :time, presence: true
  validates :time, uniqueness: { scope: [:date, :cafe],
    message: "You can't make a booking at this time!" }
  validates :user_id, presence: true
  validates :table_num, presence: true
  validates :table_num, numericality: { other_than: 0 }
  validates :cafe_id, presence: true
  validates :table_num, numericality: { only_integer: true }
end
