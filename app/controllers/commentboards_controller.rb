class CommentboardsController < ApplicationController
before_action :set_post
  before_action :set_commentboard, only: :destroy

  def create
    @commentboard = @post.commentboards.new(commentboard_params)
    @commentboard.save
  end

  def destroy
    @commentboard.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @commentboard = @post.commentboards.find(params[:id])
  end

  def commentboard_params
    params.require(:commentboard).permit(:body)
  end
end
