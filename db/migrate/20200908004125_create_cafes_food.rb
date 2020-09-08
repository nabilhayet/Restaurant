class CreateCafesFood < ActiveRecord::Migration[6.0]
  def change
    create_table :cafes_food do |t|
      t.belongs_to :cafe, null: false, foreign_key: true
      t.belongs_to :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
