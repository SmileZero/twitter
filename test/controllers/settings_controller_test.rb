require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  test "should get info" do
    get :info
    assert_response :success
  end

  test "should get password" do
    get :password
    assert_response :success
  end

  test "should get avatar" do
    get :avatar
    assert_response :success
  end

end
