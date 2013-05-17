require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  test "should get user" do
    get :user
    assert_response :success
  end

  test "should get country" do
    get :country
    assert_response :success
  end

  test "should get timeline" do
    get :timeline
    assert_response :success
  end

end
