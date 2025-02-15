require "test_helper"

class BURM::MailingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = create(:burm_person)
    @site = create(:site, :burm)
    host! @site.domain
  end

  test "should get new" do
    get new_burm_mailing_path
    assert_template :new
    assert_response :success
  end

  test "should get edit" do
    get edit_burm_mailing_path(@person)
    assert_template :edit
    assert_response :success
  end

  test "should create person" do
    assert_difference("BURM::Person.count") do
      post burm_mailings_path, params: { person: attributes_for(:burm_person) }
    end

    assert @person.subscription_list.include?("email")
    assert_template :created
  end

  test "should confirm person" do
    get burm_mailing_confirm_path(burm_mailing_id: @person.id)
    assert @person.confirmed?
    assert @person.confirmed_at?
    assert_template :confirmed
    assert_response :success
  end

  test "should unsubscribe person" do
    get burm_mailing_unsubscribe_path(burm_mailing_id: @person.id)
    debugger
    
    assert @person.subscription_list.include?("unsubscribed")
    assert_not @person.subscription_list.include?("email")
    assert_template :unsubscribed
    assert_response :success
  end
end
