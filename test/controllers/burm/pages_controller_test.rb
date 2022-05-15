require "test_helper"

class Burm::PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get burm_pages_landing_url
    assert_response :success
  end
end
