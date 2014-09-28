class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :product_id
      t.integer :user_id
      t.string   :receive_name
      t.string   :addr
      t.string   :phone
      t.string  :memo
      t.integer :total_cost
      t.string :trade_type
      t.string :payer
      t.integer :status
      t.integer :ship_cost
      t.string :ship_company
      t.string :trans_num
      t.timestamps
    end
    
  end
end
