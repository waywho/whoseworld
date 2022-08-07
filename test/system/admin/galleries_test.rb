require "application_system_test_case"

class Admin::GalleriesTest < ApplicationSystemTestCase
  setup do
    @admin_gallery = admin_galleries(:one)
  end

  test "visiting the index" do
    visit admin_galleries_url
    assert_selector "h1", text: "Galleries"
  end

  test "should create gallery" do
    visit admin_galleries_url
    click_on "New gallery"

    click_on "Create Gallery"

    assert_text "Gallery was successfully created"
    click_on "Back"
  end

  test "should update Gallery" do
    visit admin_gallery_url(@admin_gallery)
    click_on "Edit this gallery", match: :first

    click_on "Update Gallery"

    assert_text "Gallery was successfully updated"
    click_on "Back"
  end

  test "should destroy Gallery" do
    visit admin_gallery_url(@admin_gallery)
    click_on "Destroy this gallery", match: :first

    assert_text "Gallery was successfully destroyed"
  end
end
