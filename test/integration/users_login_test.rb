require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
   @user = users(:gyotaek)
  end
  
   test "login with invalid information" do
    get login_path
    post sessions_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to root_path
    
  end

  
  
  
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
