require "test_helper"

class LogicalThinking::PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get logical_thinking_pages_landing_url
    assert_response :success
  end
end
