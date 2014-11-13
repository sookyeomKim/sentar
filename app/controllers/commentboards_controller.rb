class CommentboardsController < ApplicationController
before_action :set_post
  before_action :set_commentboard, only: :destroy

  def create
    @commentboard = @post.commentboards.new(commentboard_params)
    @commentboard.save
    # undefined post user
    # title = "#{@current_user.name}님이 댓글을 달았습니다."
    # message = simple_format(@commentboard.body) + "<a href='/posts/#{@post.id}'>답장하러가기</a>"
    # Pusher.trigger("mychannel-#{@micropost.user.id}", 'my-event', {:type => "new_comment", :title=>title , :message => message, :url => current_user.gravatar_url } )
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
