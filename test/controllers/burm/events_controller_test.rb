require "test_helper"

class BURM::EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = create(:site, :burm)
    host! @site.domain
  end

  test "should get index" do
    get burm_events_path
    assert_response :success
  end
end
