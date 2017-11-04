require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @other_user = users(:two)
    @user_with_files = users(:user_with_avatar)
    @user_with_disposable_files = users(:user_with_disposable_avatar)
    @admin = users(:admin)
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
        email: "possible@email.com",
        account_type: "client",
		terms_of_service: "1"}}
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

  test "can update user without password" do
    patch user_url(@user),
      params: { user: {
        password: "",
        password_confirmation: "",
        email: "possible@email.com"
        }}
    assert_redirected_to user_path(@user)

    assert_equal "possible@email.com", @user.reload.email
  end

  test "can update user with an avatar" do
    patch user_url(@user),
     params: { user: {
        avatar: fixture_file_upload('files/testupload.jpg','image/jpg')
      }}
    assert_redirected_to user_path(@user)

    assert File.exists?($carrierwave_root.join('uploads','user','avatar','980190962','testupload.jpg')),
      "Uploaded file testupload.jpg was not found in " +
      "#{$carrierwave_root.join('uploads','user','avatar','980190962','testupload.jpg')}"
  end

  test "can't update user avatar with non image" do
    patch user_url(@user),
      params: {user: {
        avatar: fixture_file_upload('files/test.pdf','.pdf')
        }}
    assert_response :success
    assert !File.exists?($carrierwave_root.join('uploads','user','avatar','980190962','test.pdf'))
  end

  test "can get avatar from user" do
    assert File.exists?(@user_with_files.avatar.file.path)
  end

  test "can update user with a resume" do
    patch user_url(@user),
     params: { user: {
        resume: fixture_file_upload('files/test.pdf','.pdf')
      }}
    assert_redirected_to user_path(@user)

    assert File.exists?($carrierwave_root.join('uploads','user','resume','980190962','test.pdf')),
      "Uploaded file testupload.jpg was not found in " +
      "#{$carrierwave_root.join('uploads','user','resume','980190962','test.pdf')}"
  end

  test "can't update user resume with non pdf" do
    patch user_url(@user),
      params: {user: {
        resume: fixture_file_upload('files/testupload.jpg','image/jpg')
        }}
    assert_response :success
    assert !File.exists?($carrierwave_root.join('uploads','user','resume','980190962','testupload.jpg'))
  end

  test "can get resume from user" do
    assert File.exists?(@user_with_files.resume.file.path)
  end

  test "can delete files from user" do
    sign_out :user
    sign_in @user_with_disposable_files
    delete user_url(@user_with_disposable_files)
    assert !File.exists?("#{$carrierwave_root.join('uploads','user','resume','1040963319','testdownload.jpg')}")
    assert !File.exists?("#{$carrierwave_root.join('uploads','user','resume','1040963319','test.pdf')}")
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



  test "non admin users can see other user pages" do
    get user_url(@other_user)
    assert_response :success
  end

  test "non admin users cannot access edit page of other users" do
    get edit_user_url(@other_user)
    assert_redirected_to root_path
  end

  test "admins can access edit page of other users" do
    sign_out :user
    sign_in @admin
    get edit_user_url(@other_user)
    assert_response :success
  end

  test "non admin users cannot update other users" do
    patch user_url(@other_user),
      params: { user: {
        password: "TestPassword",
        password_confirmation: "TestPassword",
        email: "possible@email.com"} }
    assert_redirected_to root_path

  end

  test "admins can update other users" do
    sign_out :user
    sign_in @admin
    patch user_url(@other_user),
      params: { user: {
        password: "TestPassword",
        password_confirmation: "TestPassword",
        email: "possible@email.com"
        }}
    assert_redirected_to user_path(@other_user)

    assert_equal "possible@email.com", @other_user.reload.email
  end

  test "non admin users cannot delete other users" do
    assert_difference('User.count', 0) do
      delete user_url(@other_user)
    end
    assert_redirected_to root_path
  end

  test "admins can delete other users" do
    sign_out :user
    sign_in @admin
    assert_difference('User.count', -1) do
      delete user_url(@other_user)
    end

    assert_redirected_to users_path
  end
end
