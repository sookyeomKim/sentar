class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :mailbox

  def create
  @micropost = current_user.microposts.build(micropost_params)
  
  # 에러 발생시
  #  $ sudo apt-get update
  # $ sudo apt-get install imagemagick --fix-missing
    if @micropost.save
      flash[:success] = "게시글이 등록되었습니다.!"
      redirect_to blog_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "게시글이 삭제 되었습니다."
    redirect_to blog_path
  end

  def new
    @mailbox ||= current_user.mailbox
    @micropost = Micropost.new
  end

  
  def like
   @micropost = Micropost.find(params[:id])
   if current_user.already_liked?(@micropost) 
   @micropost.likes.find_by(user_id: current_user.id).destroy
   respond_to do |format|
      format.html { redirect_back_or root_path}
      format.js
    end
   
 else
  @micropost.likes.create(user_id: current_user.id)
  respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  
 end


  end

  private
    def mailbox
    @mailbox ||= current_user.mailbox
    end 
  def micropost_params
      params.require(:micropost).permit(:title, :content, :picture, :user_id)
    end

     def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
