require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  test "user should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
   test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
   test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
   test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?
    end
  end
  
   test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal @user.reload.email, mixed_case_email.downcase
  end
  
   test "password should have a minimum length" do #패스워드가 6자이상이 아닐경우 validation 체크
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "should follow and unfollow a user" do
    gyotaek = users(:gyotaek)
    archer  = users(:archer)
    assert_not gyotaek.following?(archer)
    gyotaek.follow(archer)
    assert gyotaek.following?(archer)
    assert archer.followers.include?(gyotaek)
    gyotaek.unfollow(archer)
    assert_not gyotaek.following?(archer)
  end

  test "feed should have the right posts" do
    gyotaek = users(:gyotaek)
    archer  = users(:archer)
    lana    = users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert gyotaek.feed.include?(post_following)
    end
    # Posts from self
    gyotaek.microposts.each do |post_self|
      assert gyotaek.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not gyotaek.feed.include?(post_unfollowed)
    end
  end
  
    test "유저 삭제시 관련된 포스트들도 삭제" do
    @user.save
    @user.microposts.create!(title: "로렘 입숩", content: "로렘 입숩") #글 생성
    assert_difference 'Micropost.count', -1 do 
      @user.destroy #유저가 삭제 될 경우 해당 글이 삭제되는지 확인
    end
  end

end
