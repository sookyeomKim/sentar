class AddIndexItemIdToCartItems < ActiveRecord::Migration
  def change
    add_index :cart_items, :item_id
  end
end
