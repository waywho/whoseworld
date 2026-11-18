require "test_helper"

class Weihsihu::DevPagesControllerTest < ActionDispatch::IntegrationTest
  test "dev.weihsihu.com serves the developer page without a site record" do
    host! "dev.weihsihu.com"
    get "/"
    assert_response :success
    assert_select "h1", "WeiHsi Hu"
    assert_select "h2", "Leading the dev team at SimplyTV"
  end

  test "weihsihu.com still serves the site landing" do
    site = create(:site, :weihsi)
    host! site.domain
    get "/"
    assert_response :success
    assert_select "h2", { text: "Leading the dev team at SimplyTV", count: 0 }
  end
end
