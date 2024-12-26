require "test_helper"

class Storychor::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = create(:site, domain: "storychor.com")
  end

  test "should get landing" do
    host! @site.domain
    get "/"
    assert_response :success
  end
end
