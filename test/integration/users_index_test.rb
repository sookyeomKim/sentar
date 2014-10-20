require 'test_helper'

class UserIndexTest < ActionDispatch::IntegrationTest

def setup
    @admin     = users(:gyotaek)
    @non_admin = users(:archer)
  end



test "index including pagination" do
    log_in_as(@admin)
    get users_path
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a', user.name
    end
  end





end