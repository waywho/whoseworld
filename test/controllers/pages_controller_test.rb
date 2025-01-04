require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = create(:site, :weihsi)
    @page = @site.landing_page
  end

  test "should get index" do
    get pages_url
    assert_response :success
  end

  test "should show page" do
    get page_url(@page)
    assert_response :success
  end

  test "should show landing" do
    host! @site.domain
    get root_url
    assert_response :success
  end
end
