class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      if user.activated?
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #로그인상태 유지가 체크(1) 되었을경우 , 0 = 체크 안되었을 경우
      redirect_back_or root_url
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
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
end