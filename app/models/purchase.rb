class Purchase < ActiveRecord::Base
	belongs_to :user
	belongs_to  :product
  before_save :set_purchase


  def set_purchase
  	self.status = 0
  	self.owener_id = self.product.user_id
  	
  end




	
end
