class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id]) 
       # user 는 nil 이 아니고, 기존에  활성화 되지 않았으며  activation 키가 유저와 일지하는경우
      user.activate
      flash[:success] = "활성화 되었습니다"
      log_in user
      redirect_to user
    else
      flash[:danger] = "허가되지 않은 activation link 입니다 "
      redirect_to root_url
    end
  end
  
  end

