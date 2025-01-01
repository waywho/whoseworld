# frozen_string_literal: true

require "test_helper"

class SiteScopesTest < ActiveSupport::TestCase

  class DummyPage < ActiveRecord::Base
    self.table_name = "pages"
  end

  setup do
    @site = create(:site)
    @page = create(:page, site: @site)

    DummyPage.include SiteScopes
  end

  test "class should respond to site scopes" do
    assert_respond_to DummyPage, @site.symbolized_slug
  end
end
