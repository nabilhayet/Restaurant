class CreateCafes < ActiveRecord::Migration[6.0]
  def change
    create_table :cafes do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zipcode
      t.belongs_to :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
