class SellController < ApplicationController
	before_action :logged_in_user  #로그인 상태 필요
  def index
  	@purchases = Purchase.all
  end
end
