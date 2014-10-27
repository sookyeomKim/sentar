class AddQuantityToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :quantity, :integer
  end
end
