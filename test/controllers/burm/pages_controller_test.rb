require "test_helper"

class BURM::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = create(:site, name: "BURM", domain: "burm.com")
  end

  test "should get landing" do
    host! @site.domain
    get "/"
    assert_response :success
  end
end
