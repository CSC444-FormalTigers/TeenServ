require 'test_helper'

class SuperadminControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get superadmin_url
    assert_response :success
  end

end
