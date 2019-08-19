class Order < ActiveRecord::Migration[5.2]
  def change 
    create_table :orders do |t|
      t.string :status
      t.belongs_to :customers, index: true
      t.timestamps
    end
  end
end
