require "test_helper"

class Burm::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = create(:site, domain: "burm.com")
    @page = create(:page, title: "Landing", site: @site)
  end

  test "should get landing" do
    host! @site.domain
    get "/"
    assert_response :success
  end
end
