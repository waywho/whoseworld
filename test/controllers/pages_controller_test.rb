require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = create(:site, name: "burm")
    @page = @site.landing_page
  end

  test "should get index" do
    host! @site.domain
    get pages_url
    assert_response :success
  end

  test "should show page" do
    host! @site.domain
    get page_url(@page)
    assert_response :success
  end

  test "should show generic landing" do
    host! @site.domain
    get root_url
    assert_template "pages/landing"
  end

  test "should show landing with layout for admin" do
    sign_in users(:admin)
    host! @site.domain
    get root_url
    assert_template "pages/landings/#{@site.layout_style}"
  end

  test "should show landing with layout for public site" do
    @site.update(public: true)
    sign_in users(:admin)
    host! @site.domain
    get root_url
    assert_template "pages/landings/#{@site.layout_style}"
  end
end
