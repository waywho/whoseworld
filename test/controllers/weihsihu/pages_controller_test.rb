require "test_helper"

class Weihsihu::PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get weihsihu_pages_landing_url
    assert_response :success
  end
end
