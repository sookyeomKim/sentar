require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup #유저 객체 초기
    @user = users(:gyotaek)
    # :gyotaek is defined on users.yml(test/fixtures/users.yml)
  end


 test "unsuccessful edit" do  # 업데이트 실패 테스트
    log_in_as(@user) #login first log_is_as(@user) 메서드 : test/test_helper.rb에 정의
    get edit_user_path(@user) # 유저객체를 파라미터로해서 에디트 폼 얻어오기 
    patch user_path(@user), user: { name:  '',
                                    email: '',
                                   password:              '',
                                   password_confirmation: '' } # 공백값들로 업데이트 
    assert_template 'users/edit' #업데이트 실패후 에디트 페이지로 이동 확인
  end


  
  test "successful edit" do #업데이트 성공 테스트
    log_in_as(@user) #login first
    get edit_user_path(@user) 
    name  = "GyoTaek"
    email = "foo@bar.com" 
   
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "foobar",
                                    password_confirmation: "foobar" }
    # 위의 테스트 과정과 동일하게 에디트 폼 얻어온후 validation 값으로 :name, :email 변수 설정
    assert flash.empty? #에러가 발생했을때 메세지가 채워질 flash가 비워있지 않는지(즉, 에러가 발생하지 않는 지) 체크 
    assert_redirected_to @user #업데이트를 완료하고 show 액션으로 리다이렉트 되었는지 체크
    @user.reload #데이터베이스 값이 변경되었는지 확인하기위해 유저 리로드
    assert_equal @user.name,  name  
    assert_equal @user.email, email
    #DB에서 불러온 name, email 값들이 일치한지 확인
  end

end
