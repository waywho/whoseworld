require "test_helper"

class PageTest < ActiveSupport::TestCase
  setup do
    create(:site, :weihsi)
  end

  test "should add itself to the menu_item if page is a menu page" do
    page = create(:page, kind: :menu)
    assert page.menu_item.present?
  end
end
