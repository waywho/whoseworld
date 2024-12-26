require "test_helper"

class Weihsihu::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = sites(:weihsi)
  end

  test "should get landing" do
    host! @site.domain
    get "/"
    assert_response :success
  end
end
