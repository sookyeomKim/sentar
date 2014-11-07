class HomeController < ApplicationController
	before_action :logged_in_user
  

  def index
  	@shelters = Shelter.all
  	
  	@user = current_user
  	@microposts= Micropost.from_users_followed_by(@user)
  	@micropost = current_user.microposts.build 
  	@comments = @micropost.comments.all
   @comment = @micropost.comments.build
   @products = @user.productFeed

   #@conversations = current_user.mailbox.inbox
  end


end