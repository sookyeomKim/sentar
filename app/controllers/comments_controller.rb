class CommentsController < ApplicationController
  
  before_action :set_comment, only: [ :destroy]
  before_action :correct_user, only: [ :destroy]

  # GET /comments
  # GET /comments.json
  

  # def index
  #   @comments = Comment.all
  # end

  # GET /comments/1
  # GET /comments/1.json
  # def show
  # end

  # GET /comments/new
  # def new
  #   @user |= current_user
  #   @comment = @user.comments.new
  # end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @micropost = @comment.micropost
    @product = @comment.product

    respond_to do |format|
      if @comment.save
        format.html { redirect_back_or root_path}
        #format.json { render :show, status: :created, location: @comment }
        format.js
      else
        format.html { render :new }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  # def update
  #   respond_to do |format|
  #     if @comment.update(comment_params)
  #       format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @comment }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      #format.html { redirect_back_or root_path  }
      #format.json { head :no_content }
      format.js
    end
  end

  private
    def correct_user
    @comment = Comment.find(params[:id])
     redirect_back_or root_path unless current_user?(@comment.user) or current_user?(@comment.micropost.user)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :user_name, :content, :micropost_id, :product_id)
    end
end
