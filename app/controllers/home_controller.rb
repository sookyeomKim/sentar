class HomeController < ApplicationController
	before_action :logged_in_user
  before_action :mailbox

  def index
  	@shelters = Shelter.all
  	
  	@user = User.find(current_user.id)
  	@microposts= Micropost.from_users_followed_by(@user)
  	@micropost = current_user.microposts.build 
  	@comments = @micropost.comments.all
   @comment = @micropost.comments.build
   @products = @user.productFeed

   #@conversations = current_user.mailbox.inbox
  end


private
  def mailbox
    @mailbox ||= current_user.mailbox
  end
end