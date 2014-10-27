require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:gyotaek) 
  end

  # test "profile display" do
  #   get user_path(@user)
  #   assert_select 'title', full_title(@user.name)
  #   assert_match @user.name, response.body
  #   assert_select 'img.gravatar'
  #   assert_match @user.microposts.count.to_s, response.body
   
  #   @user.microposts.paginate(page: 1).each do |micropost|
  #     assert_match micropost.content, response.body
  #   end
  # end
end