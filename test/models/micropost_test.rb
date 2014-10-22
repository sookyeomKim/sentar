require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:gyotaek)
    @micropost = @user.microposts.build(title: "Lorem ipsum", content: "Lorem ipsum")
  end

  test "micropost should be valid" do #validation 체크
    assert @micropost.valid?
  end

  test "user id should be present" do #유저아이디 공백 금지확인 체크
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present " do #내용 attribute 공백 금지확인 체크
    @micropost.content = " "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do # 내용은 140이상 될 수 없음
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "최신 글 순서대로 보이기" do
    assert_equal Micropost.first, microposts(:most_recent)
  end
end
