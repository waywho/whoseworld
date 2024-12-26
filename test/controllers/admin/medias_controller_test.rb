require "test_helper"

class Admin::MediasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @media = create(:media)
    sign_in users(:admin)
  end

  test "should get index" do
    get admin_medias_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_media_url(@media)
    assert_response :success
  end

  test "should create media" do
    assert_difference("Media.count") do
      post admin_medias_url, params: { media: { title: "Great recording", source: "a place", page_id: create(:page).id  } }
    end

    assert_redirected_to admin_media_url(Media.last)
  end

  test "should show media" do
    get admin_media_url(@media)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_media_url(@media)
    assert_response :success
  end

  test "should update admin_media" do
    patch admin_media_url(@media), params: { media: { title: "Wow" } }
    assert_redirected_to admin_media_url(@media)
  end

  test "should destroy admin_media" do
    assert_difference("Media.count", -1) do
      delete admin_media_url(@media)
    end

    assert_redirected_to admin_medias_url
  end
end
