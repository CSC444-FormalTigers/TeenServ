require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = User.new
    @user = User.new
    @user.username = "somename"
    @user.password = "something"
    @user.email = "something@thing.com"
    @user.paypal_email = "something@thing.com"
    @user.account_type = "employer"
    @user.terms_of_service = "1"
  end

  test "should not save empty user" do
    user = User.new
    assert_not user.save, "Saved an empty user"
  end

  test "should save a valid users" do
    User.ACCOUNT_TYPES.each do |acc_type|
      @user.account_type = acc_type
      assert @user.save, "Did not save a valid " + acc_type + " user."
    end
  end


  test "should not save user when username empty" do
    @user.username = ""
    assert_not @user.save, "Saved a user with empty username"
  end

  test "should not save user when password empty" do
    @user.password = ""
    assert_not @user.save, "Saved a user with empty password"
  end


  test "should not save user when email empty" do
    @user.email = ""
    assert_not @user.save, "Saved a user with empty email"
  end

  test "should not save user when account type is empty" do
    @user.account_type = ""
    assert_not @user.save, "Saved a user with empty email"
  end

  test "can check for admin" do
    @user.admin = true
    assert @user.admin?
  end

  test "superadmin is also an admin" do
    @user.super_admin = true
    assert @user.admin?
  end

end
