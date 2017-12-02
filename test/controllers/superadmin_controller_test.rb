require 'test_helper'

class SuperadminControllerTest < ActionDispatch::IntegrationTest
  test "should not get admin page if while not logged in" do
    get superadmin_url
    assert_redirected_to root_path
  end

end
