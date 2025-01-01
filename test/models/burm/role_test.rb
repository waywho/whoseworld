# frozen_string_literal: true

require "test_helper"

class BURM::RoleTest < ActiveSupport::TestCase
  setup do
    @musical = create(:burm_musical)
    @role = create(:burm_role, musical: @musical)
  end

  test "validates uniqueness of name" do
    role = build(:burm_role, musical: @musical, name: @role.name)
    assert_not role.valid?
    assert_equal ["has already been taken"], role.errors[:name]
  end
end
