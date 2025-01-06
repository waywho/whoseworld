require "test_helper"

class SiteTest < ActiveSupport::TestCase
  setup do
    @site = create(:site, domain: "burm.com")
    create(:domain_alias, domain: "burm-test.com", site: @site)
  end

  test "#find_by_domain" do
    assert_equal @site, Site.find_by_domain("burm.com")
  end

  test "#find_by_domain with alias" do
    assert_equal @site, Site.find_by_domain("burm-test.com")
  end

  test "should automatically create landing page" do
    site = create(:site, domain: "test.com")
    assert site.landing_page.present?
  end

  test "automatically populate slug" do
    site = create(:site, name: "Test Site")
    assert_equal "test-site", site.reload.slug
  end

  test "automatically generates standard site contents" do
    site = create(:site)
    assert_includes site.pages.pluck(:title), "Imprint"
    assert_includes site.pages.pluck(:title), "Privacy Policy"
    assert_includes site.pages.pluck(:title), "Terms of Service"
  end
end
