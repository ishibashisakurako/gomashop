class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, foreigh_key: true, null: false
      t.integer :shopping_cost, default: 0, null: false
      t.integer :total_payment, default: 0, null: false
      t.integer :payment_method, default: 0, null: false
      t.string :postal_code
      t.string :address
      t.string :telephone_number

      t.timestamps
    end
  end
end
