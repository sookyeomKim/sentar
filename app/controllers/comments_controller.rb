class CommentsController < ApplicationController
  #여기 부분에 관한 설명은 모두 Bulletin과 Post를 연결한것과 많이 다르지 않기때문에 자세히 적지 않는다.
  before_action :set_post
  before_action :set_comment, only: :destroy
  
  def create
    @comment = @post.comments.new(comment_params)
    @comment.save
  end

  def destroy
    @comment.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
