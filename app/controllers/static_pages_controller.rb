class StaticPagesController < ApplicationController
  def home
     if logged_in?
  	   @micropost = current_user.microposts.build 
     @user = current_user
     @microposts = current_user.microposts.paginate(page: params[:page])
     @comments = @micropost.comments.all
     @comment = @micropost.comments.build
     @mailbox ||= current_user.mailbox

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
