class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :uid 
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :contact

      t.timestamps
    end
  end
end
