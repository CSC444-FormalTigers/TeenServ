require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should not save empty user" do
    user = User.new
    assert_not user.save, "Saved an empty user"
  end

  test "should save valid user" do
    user = User.new
    user.username = "somename"
    user.password = "something"
    user.email = "something@thing.com"
    user.account_type = "client"
    assert user.save, "Did not save a valid user"
    user.destroy
  end

  test "should not save user when username empty" do
    user = User.new
    user.password = "something"
    user.email = "something@thing.com"
    user.account_type = "client"
    assert_not user.save, "Saved a user with empty username"
  end

  test "should not save user when password empty" do
    user = User.new
    user.username = "somename"
    user.email = "something@thing.com"
    user.account_type = "client"
    assert_not user.save, "Saved a user with empty password"
  end

  
  test "should not save user when email empty" do
    user = User.new
    user.username = "somename"
    user.password = "somepassword"
    user.account_type = "client"
    assert_not user.save, "Saved a user with empty email"
  end
  
  test "should not save user when account type is empty" do
    user = User.new
    user.username = "somename"
    user.password = "somepassword"
    user.email = "something@thing.com"
    assert_not user.save, "Saved a user with empty email"
  end

end
