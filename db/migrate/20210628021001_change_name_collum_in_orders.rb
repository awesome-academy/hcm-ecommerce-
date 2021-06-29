class ChangeNameCollumInOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :name, :fullname
  end
end
