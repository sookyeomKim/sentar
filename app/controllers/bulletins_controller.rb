class BulletinsController < ApplicationController
  before_action :set_shelter
  before_action :set_bulletin, only: [:show, :edit, :update, :destroy]

  # GET /bulletins
  # GET /bulletins.json
  def index
    if params[:shelter_id]
      @bulletins = @shelter.bulletins.all
    else
      @bulletins = Bulletin.all
    end
  end

  # GET /bulletins/1
  # GET /bulletins/1.json
  def show
  end

  # GET /bulletins/new
  def new
    @bulletin = @shelter.bulletins.new
  end

  # GET /bulletins/1/edit
  def edit
  end

  # POST /bulletins
  # POST /bulletins.json
  def create
    @bulletin = @shelter.bulletins.new(bulletin_params)

    respond_to do |format|
      if @bulletin.save
        format.html { redirect_to [@shelter.bulletin, @bulletin], notice: 'Bulletin was successfully created.' }
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
        format.html { redirect_to [@shelter.bulletin, @bulletin], notice: 'Bulletin was successfully updated.' }
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
      

    def set_shelter
      #@shelter = Shelter.find(params[:shelter_id])
      @shelter = Shelter.find(current_user.shelter)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_bulletin
      if params[:shelter_id]
        @bulletin = @shelter.bulletins.friendly.find(params[:id])
      else
        @bulletin = Bulletin.friendly.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :post_type)
    end
end
