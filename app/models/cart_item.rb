class CartItem < ActiveRecord::Base
	
	 acts_as_shopping_cart_item_for :cart
	 has_one :product , foreign_key: "id", primary_key: "item_id"





	 
	 def CartItem.rm_product_incart(product)
	 	@cart_items = CartItem.where(item_id: product.id)
  		@cart_items.each  do |item|
  		item.destroy
	  	end 
	 end

end



