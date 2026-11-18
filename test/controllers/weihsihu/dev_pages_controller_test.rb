require "test_helper"

class Weihsihu::DevPagesControllerTest < ActionDispatch::IntegrationTest
  test "dev.weihsihu.com serves the developer page without a site record" do
    host! "dev.weihsihu.com"
    get "/"
    assert_response :success
    assert_select "h1", "WeiHsi Hu"
    assert_select "h2", "Leading dev team at SimplyTV"
  end

  test "dev.weihsihu.com sends every other path to the developer page" do
    create(:site, :weihsi)
    host! "dev.weihsihu.com"
    get "/about"
    assert_redirected_to "http://dev.weihsihu.com/"
  end

  test "the developer page loads no third-party fonts" do
    host! "dev.weihsihu.com"
    get "/"
    assert_no_match "fonts.googleapis.com", response.body
    assert_match "League Spartan", response.body
  end

  test "the developer page carries no build notes in its source" do
    host! "dev.weihsihu.com"
    get "/"
    assert_no_match "Hallmark", response.body
  end

  test "weihsihu.com still serves the site landing" do
    site = create(:site, :weihsi, public: true)
    host! site.domain
    get "/"
    assert_response :success
    assert_template "weihsihu/landing"
  end
end
