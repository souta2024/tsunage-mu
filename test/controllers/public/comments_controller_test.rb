require "test_helper"

class Public::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_comments_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_comments_edit_url
    assert_response :success
  end

  test "should get update_history" do
    get public_comments_update_history_url
    assert_response :success
  end
end
