require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  #Include devise test helpers
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  teardown do
    Rails.cache.clear
    sign_out :user
  end

  test "can get index of users" do
    get "/users"
    assert_response :success
  end

  test "can't get users when not logged in" do
    sign_out :user
    get "/users"
    assert_redirected_to "/users/sign_in"
    sign_in @user
  end

  test "can't create a user while signed in" do
    assert_no_difference('User.count') do
      post users_url, params: {user: {
        username: "PossibleUserName",
        password: "PossiblePassword",
        email: "Possible@Email.com"}}
    end
    assert_redirected_to root_path
  end

  test "can create a user" do
    sign_out :user
    assert_difference('User.count') do
      post users_url, params: {user: {
        username: "PossibleUserName",
        password: "PossiblePassword",
        email: "possible@email.com"}}
    end

    assert_redirected_to root_path
    assert_equal 'PossibleUserName', User.last.username
    sign_in users(:one)
  end

  test "can't show user when not signed in" do
    sign_out :user
    get user_url(@user)
    assert_redirected_to "/users/sign_in"
    sign_in @user
  end

  test "can show a user" do
    get user_url(@user)
    assert_response :success
  end

  test "can't edit page of user when not signed in" do
    sign_out :user
    get edit_user_url(@user)
    assert_redirected_to "/users/sign_in"
    sign_in @user
  end

  test "can go to edit page of user" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "can update user" do
    patch user_url(@user),
      params: { user: {
        password: "TestPassword",
        password_confirmation: "TestPassword",
        email: "possible@email.com"} }
    assert_redirected_to user_path(@user)

    assert_equal "possible@email.com", @user.reload.email
  end

  test "can delete a user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_path
  end

  test "can't delete a user when not signed in" do
    sign_out :user
    assert_no_difference('User.count',-1) do
        delete user_url(@user)
    end

    assert_redirected_to "/users/sign_in"
    sign_in @user
  end

end
