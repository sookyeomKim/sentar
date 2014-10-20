require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   def setup #fixture에 저장된 유저들로 세팅
    @user = users(:gyotaek)
    @other = users(:archer)
    log_in_as(@user)
  end





test "should follow a user" do #동기 비동기 방식으로 팔로잉 체크 
    assert_difference '@user.following.count', 1 do
      post relationships_path, followed_id: @other.id
    end
    @user.unfollow(@other)
    assert_difference '@user.following.count', 1 do
      xhr :post, relationships_path, followed_id: @other.id
    end
  end

  test "should unfollow a user" do #동기 비동기 방식으로 팔로우 해제 작동 확인
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@user.following.count', -1 do
      delete relationship_path(relationship),
             relationship: relationship.id
    end
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@user.following.count', -1 do
      xhr :delete, relationship_path(relationship),
                   relationship: relationship.id
    end
  end
end
