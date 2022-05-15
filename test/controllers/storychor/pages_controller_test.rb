require "test_helper"

class Storychor::PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get storychor_pages_landing_url
    assert_response :success
  end
end
