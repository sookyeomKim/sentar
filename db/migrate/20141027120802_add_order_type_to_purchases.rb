class AddOrderTypeToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :ordertype, :string
  end
end
