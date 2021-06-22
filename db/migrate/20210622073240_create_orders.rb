class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.string :address
      t.string :name
      t.string :phone_number

      t.timestamps
    end
  end
end
