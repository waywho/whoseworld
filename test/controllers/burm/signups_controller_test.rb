require "test_helper"

class BURM::SignupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @musical = create(:burm_musical)
    @signup = create(:burm_signup)
    @site = create(:site, :burm)
    host! @site.domain
  end

  test "should get new" do
    get new_signup_path(@musical)
    assert_response :success
  end

  test "should get create" do
    post signups_path(@musical)
    assert_response :created
  end

  test "should get edit" do
    get edit_signup_path(@musical, @signup)
    assert_response :success
  end

  test "should put update" do
    put signup_path(@musical, @signup)
    assert_response :success
  end

  test "should delete" do
    delete signup_path(@musical, @signup)
    assert_response :no_content
  end
end
