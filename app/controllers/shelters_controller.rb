class SheltersController < ApplicationController
  before_action :set_shelter, only: [:show, :edit, :update, :destroy, :create]
  before_action :set_user
  
  #before_action :set_tmap, only: [:index, :show, :edit, :update, :destroy]
  

  respond_to :html, :js


  # GET /shelters
  # GET /shelters.json
  def index
   @search = Shelter.search do
    fulltext params[:search]
    end
   @shelters = @search.results
end
  # GET /shelters/1
  # GET /shelters/1.json
  def show
 @shelter = Shelter.find(params[:id])
 @user = @shelter.user
 @mailbox ||= current_user.mailbox
  end


  
  # GET /shelters/new
  def new
    #@shelter = @user.shelter.new
    #redirect_to [@user.shelter, @shelter]
    @user = User.find(current_user.id)
    @shelter = Shelter.new(user_id: @user.id)
    
  end

  # GET /shelters/1/edit
  def edit
  end

  # POST /shelters
  # POST /shelters.json
  def create
    #@shelter = Shelter.new(shelter_params)
    #@shelter = @user.shelters.new(shelter_params)
    #@tmap = Tmap.new(id: 1)
    #@shelter.tmap_id = @tmap.id
    respond_to do |format|
      if @shelter.save
        format.html { redirect_to @shelter, notice: 'Shelter was successfully created.' }
        #format.json { render :show, status: :created, location: @shelter }
        format.json { render json: @shelter }
      else
        format.html { render :new }
        #format.json { render json: @shelter.errors, status: :unprocessable_entity }
        format.json { render json: @shelter.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end
#[@tmap.shelter, @shelter]
  # PATCH/PUT /shelters/1
  # PATCH/PUT /shelters/1.json
  def update
    respond_to do |format|
      if @shelter.update(shelter_params)
        format.html { redirect_to @shelter, notice: 'Shelter was successfully updated.' }
        #format.json { render :show, status: :ok, location: @shelter }
        format.json { render json: @shelter }
      else
        format.html { render :edit }
        #format.json { render json: @shelter.errors, status: :unprocessable_entity }
        format.json { render json: @shelter.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shelters/1
  # DELETE /shelters/1.json
  def destroy
    @shelter.destroy
    respond_to do |format|
      format.html { redirect_to shelters_url, notice: 'Shelter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private
  

    def set_user
      #@user = current_user
      #@shelter = Shelter.create(user)
      @user ||= current_user
    end


    

    # Use callbacks to share common setup or constraints between actions.
    def set_shelter
      #@shelter = Shelter.find(params[:id])
      @shelter = @shelter ||current_user.shelter || Shelter.create!(user_id: current_user.id, introduce: "empty", lonlat: 0000)
      #@tmap = Tmap.find_by(id: 1)
      #@shelter.tmap_id = @tmap
      
    end

    #def set_tmap
      #@tmap = Tmap.find_by(id: 1)
      #@tmap = Tmap.find(params[:tmap_id])
    #end
    # Never trust parameters from the scary internet, only allow the white list through.
    def shelter_params
      params.require(:shelter).permit(:name, :introduce, :kind, :lonlat)
    end
end
