require "test_helper"

class Public::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_notifications_index_url
    assert_response :success
  end

  test "should get show" do
    get public_notifications_show_url
    assert_response :success
  end
end
