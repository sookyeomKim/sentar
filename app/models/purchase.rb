class Purchase < ActiveRecord::Base
	belongs_to :user
	belongs_to  :product
  
  

  



 def status_kr

 if self.status == 0  
 	status = "입금확인중"
 elsif self.status == 1 
 	status = "발송준비"
 elsif self.status == 2 
 	status = "발송완료"
 elsif self.status == 3 
 	status = "배송중"
 elsif self.status == 4 
 	status = "배송완료"
 elsif self.status == 5 
 	status = "주문취소"
  end
end

def cancel_order
self.update_attributes!(:status, 5)
end


end
