require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = sites(:example)
    @page = create(:page, title: "Landing", site: @site)
  end

  test "should get index" do
    get pages_url
    assert_response :success
  end

  test "should show page" do
    get page_url(@page)
    assert_response :success
  end
end
