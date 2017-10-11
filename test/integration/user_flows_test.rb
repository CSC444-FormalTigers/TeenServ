require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = users(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test "can get index of users" do
    get "/users"
    assert_response :success
  end

  test "can create a user" do
    assert_difference('User.count') do
      post users_url, params: {user: {
        username: "PossibleUserName",
        password: "PossiblePassword",
        email: "Possible@Email.com"}}
    end

    assert_redirected_to user_path(User.last)
    assert_equal 'PossibleUserName', User.last.username
  end

  test "can show a user" do
    get user_url(@user)
    assert_response :success
  end

  test "can go to edit page of user" do
    get edit_user_url(@user)
    assert_response :success
  end

  #test "can update user" do
  #  patch user_url(@user),
  #    params: { user: {
  #      password: "TestPassword",
  #      password_confirmation: "TestPassword",
  #      email: "Possible@Email.com"} }
  #  assert_redirected_to user_path(@user)

  #  assert_equal "Possible@Email.com", @user.reload.email
  #end

  test "can delete a user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_path
  end

end
