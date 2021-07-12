class AddDeletedToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :deleted, :boolean, default: false
  end
end
