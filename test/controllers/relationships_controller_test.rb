require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
   test "팔로잉 할 경우 로그인 상태인지 체크" do
    assert_no_difference 'Relationship.count' do # 릴레이션 객체 수에 변화가 없는지 확인
      post :create #post방식으로 새로운 관계 객체 생성 요청
    end
    assert_redirected_to login_url #로그인 상태가 아니기 때문에 로그인 창으로 이동 확인
  end

  
end
