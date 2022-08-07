require "test_helper"

class Admin::GalleriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_gallery = admin_galleries(:one)
  end

  test "should get index" do
    get admin_galleries_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_gallery_url
    assert_response :success
  end

  test "should create admin_gallery" do
    assert_difference("Admin::Gallery.count") do
      post admin_galleries_url, params: { admin_gallery: {  } }
    end

    assert_redirected_to admin_gallery_url(Admin::Gallery.last)
  end

  test "should show admin_gallery" do
    get admin_gallery_url(@admin_gallery)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_gallery_url(@admin_gallery)
    assert_response :success
  end

  test "should update admin_gallery" do
    patch admin_gallery_url(@admin_gallery), params: { admin_gallery: {  } }
    assert_redirected_to admin_gallery_url(@admin_gallery)
  end

  test "should destroy admin_gallery" do
    assert_difference("Admin::Gallery.count", -1) do
      delete admin_gallery_url(@admin_gallery)
    end

    assert_redirected_to admin_galleries_url
  end
end
