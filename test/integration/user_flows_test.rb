require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "can create a user" do
    get "/users/new"
    assert_response :success

    post "/users",
      params: { user: {
        username: "PossibleUserName",
        password: "PossiblePassword",
        email: "Possible@Email.com"}}

    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

end
