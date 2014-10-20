require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
    test "current_user" do
    user = users(:gyotaek) #fixtures 폴더에 있는 users.yml에 저장되어 있는 유저 gyotaek load
    remember(user) #로그인 상태 유지
    assert_equal current_user, user #현재 세션에 있는 유저와 로그인한 유저가 같은지 체크
  end
end
