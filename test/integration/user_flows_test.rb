require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

  setup do
    @other_user = users(:two)
    @admin = users(:admin)
  end

end
