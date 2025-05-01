class AddOthersToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :others, :text
  end
end
