require "test_helper"

class Admin::MediasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_media = admin_medias(:one)
  end

  test "should get index" do
    get admin_medias_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_media_url
    assert_response :success
  end

  test "should create admin_media" do
    assert_difference("Admin::Media.count") do
      post admin_medias_url, params: { admin_media: {  } }
    end

    assert_redirected_to admin_media_url(Admin::Media.last)
  end

  test "should show admin_media" do
    get admin_media_url(@admin_media)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_media_url(@admin_media)
    assert_response :success
  end

  test "should update admin_media" do
    patch admin_media_url(@admin_media), params: { admin_media: {  } }
    assert_redirected_to admin_media_url(@admin_media)
  end

  test "should destroy admin_media" do
    assert_difference("Admin::Media.count", -1) do
      delete admin_media_url(@admin_media)
    end

    assert_redirected_to admin_medias_url
  end
end
