class HomeController < ApplicationController
	before_action :logged_in_user

  def index
  	@shelters = Shelter.all
  	@blogs= Micropost.all
  	@user = User.find(current_user.id)
	@products = @user.productFeed
  end

end
