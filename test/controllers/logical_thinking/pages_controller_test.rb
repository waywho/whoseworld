require "test_helper"

class LogicalThinking::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = sites(:logical)
    @page = create(:page, title: "Landing", site: @site)
  end

  test "should get landing" do
    host! @site.domain
    get "/"
    assert_response :success
  end
end
