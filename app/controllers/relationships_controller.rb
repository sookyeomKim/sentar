class RelationshipsController < ApplicationController

before_action :logged_in_user

  def create
  	@user = User.find(params[:followed_id])
    current_user.follow(@user)
    Pusher.trigger('my-channel', 'my-event', {:message => @user.name})
     respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
  	@user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end

  end
end