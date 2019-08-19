class OrderPRoduct < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.integer :order, index: true
      t.integer :product, index: true
      t.timestamps
    end
  end
end
