require "application_system_test_case"

class Admin::PagesTest < ApplicationSystemTestCase
  setup do
    @site = sites(:example)
    @page = create(:page, site: @site)
    sign_in users(:admin)
  end

  test "visiting the index" do
    visit admin_pages_url(site_id: @site)
    assert_selector "h1", text: "Pages"
    assert_link @page.title
  end

  test "should create page" do
    visit admin_pages_url
    click_on "New Page"

    fill_in "Title", with: "Hello"
    click_on "Create Page"

    assert_text "Page was successfully created"
    click_on "Back"
  end

  test "should update Page" do
    visit admin_pages_url
    click_on @page.title, match: :first

    click_on "Update Page"

    assert_text "Page was successfully updated"
    click_on "Back"
  end
end
