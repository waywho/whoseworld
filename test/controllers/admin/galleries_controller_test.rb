require "test_helper"

class Admin::GalleriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gallery = create(:gallery)
    sign_in users(:admin)
  end

  test "should get index" do
    get admin_galleries_path
    assert_response :success
  end

  test "should get new" do
    get new_admin_gallery_url
    assert_response :success
  end

  test "should create admin_gallery" do
    assert_difference("Gallery.count") do
      post admin_galleries_url, params: { gallery: { description: "Great art", page: create(:page), title: "Art" } }
    end

    assert_redirected_to admin_gallery_path(Gallery.last)
  end

  test "should show admin_gallery" do
    get admin_gallery_url(@gallery)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_gallery_url(@gallery)
    assert_response :success
  end

  test "should update gallery" do
    patch admin_gallery_url(@gallery), params: { gallery: { description: "I am a picture" } }
    assert_redirected_to admin_gallery_url(@gallery)
  end

  test "should destroy gallery" do
    assert_difference("Gallery.count", -1) do
      delete admin_gallery_url(@gallery)
    end

    assert_redirected_to admin_galleries_url
  end
end
