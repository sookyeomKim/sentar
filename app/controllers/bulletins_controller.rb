#게시판의 개념을 도입하면 원하는 만큼의 게시판을 작성하여 글을 게시판별로 묶을 수 있다.
class BulletinsController < ApplicationController
  before_action :set_bulletin, only: [:show, :edit, :update, :destroy] #before_action에 지정된 메서드는 지정된 액션이 실행되기 전에만 수행됨.
  before_action :set_shelter
  #before_action :correct_user, only: [:destroy, :edit]
  # GET /bulletins
  # GET /bulletins.json
  def index
    #@bulletins = Bulletin.all
    @bulletins = @shelter.bulletins.all
    redirect_to root_path
  end

  # GET /bulletins/1
  # GET /bulletins/1.json
  def show
  end

  # GET /bulletins/new
  def new
    #@bulletin = Bulletin.new
    @bulletin = @shelter.bulletins.new
  end

  # GET /bulletins/1/edit
  def edit
  end

  # POST /bulletins
  # POST /bulletins.json
  def create
    #@bulletin = Bulletin.new(bulletin_params)
    @bulletin = @shelter.bulletins.new(bulletin_params)
    respond_to do |format|
      if @bulletin.save
        format.html { redirect_to [@bulletin.shelter, @bulletin], notice: 'Bulletin was successfully created.' }
        format.json { render :show, status: :created, location: @bulletin }
      else
        format.html { render :new }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bulletins/1
  # PATCH/PUT /bulletins/1.json
  def update
    respond_to do |format|
      if @bulletin.update(bulletin_params)
        format.html { redirect_to [@bulletin.shelter, @bulletin], notice: 'Bulletin was successfully updated.' }
        format.json { render :show, status: :ok, location: @bulletin }
      else
        format.html { render :edit }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulletins/1
  # DELETE /bulletins/1.json
  def destroy
    @bulletin.destroy
    respond_to do |format|
      format.html { redirect_to shelter_bulletins_url, notice: 'Bulletin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private 

  # correct 유저 확인
    #def correct_user
    #  @user = User.find(params[:id])
    #  redirect_to(bulletin_path) unless current_user?(@user)
    #end

    def set_shelter
      @shelter = Shelter.find(current_user.shelter)
    end
    def set_bulletin
      #@bulletin = Bulletin.find(params[:id])
      @bulletin = Bulletin.friendly.find(params[:id]) #friendly젬 추가(id값 대신에 다른 속성값을 받을거기 때문에)

    end

    def bulletin_params
      #params.require(:bulletin).permit(:title, :description)
      params.require(:bulletin).permit(:title, :description, :post_type)#게시판 타입을 지정해줄 모델을 마이그레이션 한다음에 속성 추가
    end
end
