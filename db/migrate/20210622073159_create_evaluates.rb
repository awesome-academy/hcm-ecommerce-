class CreateEvaluates < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluates do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.integer :star

      t.timestamps
    end
  end
end
