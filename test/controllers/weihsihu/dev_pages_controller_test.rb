require "test_helper"

class Weihsihu::DevPagesControllerTest < ActionDispatch::IntegrationTest
  test "dev.weihsihu.com serves the developer page without a site record" do
    host! "dev.weihsihu.com"
    get "/"
    assert_response :success
    assert_equal "weihsihu/dev_pages", controller.controller_path
  end

  test "dev.weihsihu.com sends every other path to the developer page" do
    create(:site, :weihsi)
    host! "dev.weihsihu.com"
    get "/about"
    assert_redirected_to "http://dev.weihsihu.com/"
  end

  test "weihsihu.com still goes to the site pages" do
    site = create(:site, :weihsi)
    host! site.domain
    get "/"
    assert_response :success
    assert_equal "pages", controller.controller_path
  end
end
