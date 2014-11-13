class SessionsController < ApplicationController
  before_action :not_logged_in_user, only: [:new]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      if user.activated?
      log_in user
      title = "#{current_user.name}님이 로그인 하였습니다."
      message = "<a href='/users/#{current_user.id}' >방문하기</a>"

      current_user.followers.each do |follower|
      Pusher.trigger("mychannel-#{follower.id}", 'my-event', {:type => "following_login", :title=>title , :message => message, :url => current_user.gravatar_url } )  
      end

      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #로그인상태 유지가 체크(1) 되었을경우 , 0 = 체크 안되었을 경우
      redirect_back_or root_url
      else
        message  = "계정이 활성화 되지 않았습니다."
        message += "이메일을 확인해 주세요 :)"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # Create an error message.
      flash.now[:danger] = '존재하지 않는 email이거나 잘못된 비밀번호 입니다' # Not quite right!
      render 'new'
    end
  end

  def destroy
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end
  # Ends a temporary browser session.
  def end_session
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end


  def not_logged_in_user
      if logged_in?
        redirect_to root_path
      end
    end
end