require "test_helper"

class Burm::RoleTest < ActiveSupport::TestCase
  setup do
    @show = create(:burm_show)
    @role = create(:burm_role, burm_show: @show)
  end

  test "validates uniqueness of name" do
    role = build(:burm_role, burm_show: @show, name: @role.name)
    assert_not role.valid?
    assert_equal ["has already been taken"], role.errors[:name]
  end
end
