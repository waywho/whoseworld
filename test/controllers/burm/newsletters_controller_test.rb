require "test_helper"

class BURM::NewslettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = create(:burm_person)
    @site = create(:site, :burm)
    host! @site.domain
  end

  test "should get new" do
    get new_burm_newsletter_path
    assert_template :new
    assert_response :success
  end

  test "should get edit" do
    get edit_burm_newsletter_path(@person)
    assert_template :edit
    assert_response :success
  end

  test "should create person" do
    assert_difference("BURM::Person.count") do
      post burm_newsletters_path, params: { burm_person: attributes_for(:burm_person) }
    end

    assert_template :created
  end

  test "should confirm person" do
    get burm_newsletter_confirm_path(token: @person.confirmation_token)

    assert_template :confirmed
    assert_response :success
  end

  test "should unsubscribe person" do
    get burm_newsletter_unsubscribe_path(id: @person.id)

    assert_template :unsubscribed
    assert_response :success
  end
end
