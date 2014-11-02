class CartItem < ActiveRecord::Base
	 acts_as_shopping_cart_item_for :cart
	 has_one :product , foreign_key: "id", primary_key: "item_id"






	 
	 def removable?
	 	
	 	self.quantity > 1

	 end

end



