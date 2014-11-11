class PostsController < ApplicationController
  #before_action :set_shelter
  before_action :set_bulletin
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  

  # GET /posts
  # GET /posts.json
  def index
    if params[:bulletin_id]
      @posts = @bulletin.posts.all
    else
      if params[:tag]
        @posts = Post.tagged_with(params[:tag])
      else
        @posts = Post.all
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  @shelter = @post.bulletin.shelter
  end

  # GET /posts/new
  def new
    @post = @bulletin.posts.new
  end

  # GET /posts/1/edit
  def edit
  @bulletin = @post.bulletin
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to @bulletin.posts, notice: 'Post was successfully destroyed.' }
      # format.json { head :no_content }
      format.js
    end
  end

  private
    

    def set_bulletin
      @bulletin = Bulletin.find(params[:bulletin_id]) if params[:bulletin_id]
      #@bulletin = @shelter.bulletins.friendly.find(params[:bulletin_id]) if params[:bulletin_id]
    end

    def set_post
      if params[:bulletin_id]
        @post = @bulletin.posts.find(params[:id])
      else
        @post = Post.find(params[:id])
      end
    end

    def post_params
      params.require(:post).permit(:title, :content, :picture, :picture_cache, :tag_list, :bulletin_id)
    end
end
