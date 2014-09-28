class Cart < ActiveRecord::Base
	acts_as_shopping_cart_using :cart_item
	belongs_to :user




	def tax_pct
	0 #tax = 0
	end
end
