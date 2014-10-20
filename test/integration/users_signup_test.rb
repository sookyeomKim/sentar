require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   test "invalid signup information" do #잘못된 정보로 회원가입 할경우 로그인창으로 리다이렉트
    get signup_path #login_form
    assert_no_difference 'User.count' do #유저 수에 변화가 없음을 체크
      post users_path, user: { name:  "", #공백 validaition 체크에 걸림
                               email: "user@invalid",
                               password:              "foo", #패스워드는 6자이상이여야함
                               password_confirmation: "bar" } #기존 패스워드와 불일치
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation' #에러 메세지 태크 확인
    assert_select 'div.field_with_errors'
  end
  
  
end
