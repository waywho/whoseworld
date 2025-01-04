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
    assert_difference("Page.count") do
      site = create(:site, domain: "test.com")
      assert site.landing_page.present?
    end
  end

  test "automatically populate slug" do
    site = create(:site, name: "Test Site")
    assert_equal "test-site", site.reload.slug
  end
end
