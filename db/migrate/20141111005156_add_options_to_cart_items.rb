class AddOptionsToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :option, :string
    add_column :cart_items, :detail, :string
  end
end
