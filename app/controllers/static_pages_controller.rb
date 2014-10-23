class StaticPagesController < ApplicationController
  def home
     if logged_in?
  	   @micropost = current_user.microposts.build 
     @feed_items = current_user.feed.paginate(page: params[:page])
     @comments = @micropost.comments.all
     @comment = @micropost.comments.build

     end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end

  def sendgrid
    render text: "SendGrid"
  end
  
end
