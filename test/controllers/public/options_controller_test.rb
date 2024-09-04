require "test_helper"

class Public::OptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_options_show_url
    assert_response :success
  end

  test "should get user_info_edit" do
    get public_options_user_info_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get public_options_unsubscribe_url
    assert_response :success
  end

  test "should get terms_of_service" do
    get public_options_terms_of_service_url
    assert_response :success
  end

  test "should get user_guide" do
    get public_options_user_guide_url
    assert_response :success
  end
end
