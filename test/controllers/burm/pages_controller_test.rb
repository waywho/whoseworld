require "test_helper"

class Burm::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = create(:site, name: "Burm", domain: "burm.com")
  end

  test "should get landing" do
    host! @site.domain
    get "/"
    assert_response :success
  end
end
