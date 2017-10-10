require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "can get index of users" do
    get "/users"
    assert_response :success
  end

  test "can create a user" do
    get "/users/new"
    assert_response :success

    post "/users",
      params: { user: {
        username: "PossibleUserName",
        password: "PossiblePassword",
        email: "Possible@Email.com"}}

    assert_response :redirect
  end

  test "can show a user" do
    user = users(:one)
    get user_url(user)
    assert_response :success
  end

  test "can edit a user" do
    user = users(:one)
    get edit_user_url(user)
    assert_response :success

    patch user_url(user),
      params: { user: {
      username: "PossibleUserName",
      password: "PossiblePassword",
      email: "Possible@Email.com"}}
    assert_response :redirect

  end

  test "can delete a user" do
    user = users(:one)
    assert_difference('User.count', -1) do
      delete user_url(user)
    end

    assert_redirected_to users_path
  end

end
