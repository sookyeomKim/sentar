class SellAndBuyController < ApplicationController
  before_action :mailbox

  def main
  end

  def buy_list
  	@purchases = current_user.purchases
  end


  def sell_list
  @purchases = current_user.admin_purchases
  end

private
    def mailbox
    @mailbox ||= current_user.mailbox
    end
end