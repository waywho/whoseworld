require "test_helper"

class BURM::EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get burm_events_index_url
    assert_response :success
  end
end
