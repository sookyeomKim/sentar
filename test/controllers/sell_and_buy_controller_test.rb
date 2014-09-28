require 'test_helper'

class SellAndBuyControllerTest < ActionController::TestCase
  test "should get main" do
    get :main
    assert_response :success
  end

end
