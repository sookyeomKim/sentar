require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase

  def setup
    @micropost = microposts(:orange)
  end

  test "로그인 상태에서만 글 생성" do
    assert_no_difference 'Micropost.count' do #마이크로 포스트 객체 수에 차이가 없는지 체크(비로그인시)
      post :create, micropost: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "로그인 상태에서만 삭제 가능" do
    assert_no_difference 'Micropost.count' do #마이크로 포스트 객체 수에 차이가 없는지 체크(비로그인시)
      delete :destroy, id: @micropost
    end
    assert_redirected_to login_url
  end


  test "다른 유저의 글을 지울려고 할 경우 리다이렉트" do
    log_in_as(users(:gyotaek))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: micropost
    end
    assert_redirected_to root_url
  end

end