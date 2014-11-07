class SellAndBuyController < ApplicationController
  
  def main
  end

  def buy_list
  	@purchases = current_user.purchases
  end


  def sell_list
  @purchases = current_user.admin_purchases
  end

private
    
end