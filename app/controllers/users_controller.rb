class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
   # 모든 유저보기 , 유저 설정 , 업데이트 , 삭제 는 로그인상태일때만 가능  
  before_action :correct_user,   only: [:edit, :update] # 해당 아이디로 로그인 상태일때만 설정 및 업데이트 가능
  before_action :admin_user,     only: :destroy # destroy action은 관리자만 가능

  def new
    @user = User.new
  end
  
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user =  User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
 
def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email  #계정 활성화 이메일 발송
      flash[:info] = "메일을 발송하였습니다 확인해 주세요."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit #업데이트 유저 (view : app/views/users/edit.html.erb)
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 업데이트 성공시
      redirect_to @user
    else
      # 실패시 에디트 페이지 render
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:succes] = "삭제 완료"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
  # 로그인 상태 확인
    def logged_in_user
      unless logged_in?
        store_location # 로그인 후 유저 프로필 페이지가 아닌 edit_form으로 이동
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # correct 유저 확인
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

     # 관리자 확인
    def admin_user
      redirect_to(root_url) unless current_user.admin? #현재 유저가 관리자가 아닐경우 root 유알엘로 redirect
    end
end
