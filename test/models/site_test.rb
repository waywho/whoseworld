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
end
