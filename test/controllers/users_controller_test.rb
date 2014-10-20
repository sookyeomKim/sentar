require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
def setup
    @user       = users(:gyotaek)
    @other_user = users(:archer)
end

  test "should redirect index when not logged in" do #비로그인 상태에서 인덱스 페이지 리다이렉트
    get :index
    assert_redirected_to login_url
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end


  test "should redirect edit when not logged in" do  #로그인이 안되었을 경우 로그인 페이지로
    get :edit , id: @user
    assert_redirected_to login_url
  end

 

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user) #다른 유저로 로그인
    get :edit, id: @user #유저 아이디 업데이트 시도
    assert_redirected_to root_url # 로그인 페이지가 아님 루트 유알엘로 이동 테스트
  end


  
end