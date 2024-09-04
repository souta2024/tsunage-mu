require "test_helper"

class Public::DirectMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_direct_messages_index_url
    assert_response :success
  end

  test "should get show" do
    get public_direct_messages_show_url
    assert_response :success
  end
end
