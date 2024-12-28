require "test_helper"

class Admin::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = create(:site, :weihsi)
    @page = create(:page, site: @site)
    sign_in users(:admin)
  end

  test "should get index" do
    get admin_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_page_url
    assert_response :success
  end

  test "should create page" do
    assert_difference("Page.count") do
      post admin_pages_url, params: { page: { title: "hello", content: "hello world", site_id: @site.id } }
    end

    assert_redirected_to edit_admin_page_url(Page.last)
  end

  test "should show page" do
    get admin_preview_page_path(id: @page, site_id: @site)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_page_url(@page)
    assert_response :success
  end

  test "should update admin_page" do
    patch admin_page_url(@page), params: { page: { content: "and great", site_id: @site.id } }
    assert_redirected_to edit_admin_page_url(@page)
  end

  test "should destroy admin_page" do
    assert_difference("Page.count", -1) do
      delete admin_page_url(@page)
    end

    assert_redirected_to admin_pages_url
  end
end
