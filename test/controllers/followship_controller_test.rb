require "test_helper"

class FollowshipControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get followship_create_url
    assert_response :success
  end

  test "should get destroy" do
    get followship_destroy_url
    assert_response :success
  end
end
