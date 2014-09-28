class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  
  def new
  end


  def create # 패스워드찾기에서 submit 액션 
  @user = User.find_by(email: params[:password_reset][:email].downcase)	
  if @user
  	@user.create_reset_digest
  	@user.send_password_reset_email
  	flash[:info] = "패스워드 변경 방법이 이메일로 발송  되었습니다."
  	redirect_to root_url
  else
  	flash[:danger] = "이메일 주소를 못찾겠네요."
  	render 'new'

  end
end

  def edit
  end

  def update
    if  @user.password_reset_expired?
      flash[:danger]  = "할당 시간(2시간)이 지났습니다."
      redirect_to new_pasword_reset_path
    elsif @user.update_attributes(user_params)
      flash[:success] = "패스워드 리셋이 완료 되었습니다."
      log_in @user
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
      @user = User.find_by(email: params[:email])
      unless @user && @user.authenticated?(:reset, params[:id])
      redirect_to root_url
      
end

end

end