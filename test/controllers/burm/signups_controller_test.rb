require "test_helper"

class BURM::SignupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @musical = create(:burm_musical)
    @signup = create(:burm_signup, :with_role, musical: @musical)
    @site = create(:site, :burm)
    host! @site.domain
  end

  test "should get new only when signup is open" do
    musical = create(:burm_musical, signup_start_at: Time.current + 1.day)
    # TODO: PUT back
    # get new_burm_signup_path(musical)
    # assert_response :forbidden

    musical.update!(signup_start_at: Time.current - 1.day)
    get new_burm_signup_path(musical)
    assert_response :success
  end

  test "should get new" do
    get new_burm_signup_path(@musical)
    assert_response :success
  end

  test "should post create" do
    role = create(:burm_role, musical: @musical)
    assert_difference('BURM::Person.count') do
      assert_difference('BURM::Signup.count') do
        post burm_signups_path(@musical), params: {
          burm_signup: attributes_for(:burm_signup)
                        .merge(burm_role_id: role.id,
                               person_attributes: attributes_for(:burm_person)) }
      end
    end

    assert_redirected_to burm_signup_path(@musical, BURM::Signup.last, status: :created)
    follow_redirect!
    assert_template partial: "_created"
  end

  test "should get edit" do
    get edit_burm_signup_path(@musical, @signup)
    assert_response :success
  end

  test "should put update" do
    role = create(:burm_role, musical: @musical)
    put burm_signup_path(@musical, @signup), params: { burm_signup: { burm_role_id: role.id } }

    assert @signup.reload.role == role
    assert_redirected_to burm_signup_path(@musical, @signup, status: :updated)
    follow_redirect!
    assert_template partial: "_updated"
  end

  test "should cancel" do
    delete burm_signup_path(@musical, @signup)
    assert_response :success
  end

  test "should uncancel if cancelled" do
    @signup.update!(cancelled: true)
    patch burm_signup_path(@musical, @signup, burm_signup: { cancelled: false })

    assert_not @signup.reload.cancelled?
  end

  test "should not cancel if already cancelled" do
    @signup.update!(cancelled: true)
    delete burm_signup_path(@musical, @signup)

    assert_template :already_cancelled
    assert @signup.reload.cancelled?
  end

  test "should not update if already cancelled" do
    @signup.update!(cancelled: true)
    patch burm_signup_path(@musical, @signup)

    assert_template :already_cancelled
    assert @signup.reload.cancelled?
  end

  test "get edit should render already_cancelled if already cancelled" do
    @signup.update!(cancelled: true)
    get burm_signup_path(@musical, @signup)

    assert_template :already_cancelled
  end

  test "get show should render already_cancelled if already cancelled" do
    @signup.update!(cancelled: true)
    get edit_burm_signup_path(@musical, @signup)

    assert_template :already_cancelled
  end
end
