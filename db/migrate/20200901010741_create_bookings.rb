class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.date :date
      t.time :time
      t.integer :table_num
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :cafe, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
