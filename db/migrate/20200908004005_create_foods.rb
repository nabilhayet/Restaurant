class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :category 
      t.integer :fat
      t.integer :calories
      t.belongs_to :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
