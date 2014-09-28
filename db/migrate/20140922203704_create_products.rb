class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :user_id

      t.timestamps
    end
    add_index :products, [:user_id, :created_at]
  end
end
