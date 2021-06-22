class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :fullname
      t.integer :gender
      t.string :phone_number
      t.string :avatar
      t.datetime :date_of_birth
      t.integer :role
      t.string :address

      t.timestamps
    end
  end
end
