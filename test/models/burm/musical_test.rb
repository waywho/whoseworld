require "test_helper"

class Burm::MusicalTest < ActiveSupport::TestCase
  setup do
    @show = create(:burm_musical)
  end

  test "should initialize fee with 15.00" do
    assert_equal 15.00, @show.fee
  end
end
