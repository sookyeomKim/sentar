class StaticPagesController < ApplicationController
  def home
     if logged_in?
      @user ||= current_user
  	   @micropost ||= @user.microposts.build 
     @microposts = @user.microposts.paginate(page: params[:page])
     @comment  ||= @micropost.comments.build
     

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
