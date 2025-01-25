# frozen_string_literal: true

require "test_helper"

class BURM::MusicalTest < ActiveSupport::TestCase
  test "should initialize fee with 15.00" do
    musical = BURM::Musical.new(title: "Hamilton")
    assert_equal 15.00, musical.fee
  end

  test "should add roles when new_record" do
    musical = BURM::Musical.new(title: "Hamilton")
    musical.bulk_roles = "King George III, baritone, lead\nAlexander Hamilton, (tenor), lead"
    musical.save!

    assert_equal 2, musical.roles.count
    assert_equal "King George III", musical.roles.first.name
    assert_equal "baritone", musical.roles.first.voice_type
    assert_equal "lead", musical.roles.first.role_type
    assert_equal "Alexander Hamilton", musical.roles.last.name
    assert_equal "tenor", musical.roles.last.voice_type
    assert_equal "lead", musical.roles.last.role_type
  end

  test "shold not add roles when persisted" do
    musical = create(:burm_musical)
    create(:burm_role, name: "King George III", voice_type: :baritone, role_type: :lead,  musical:)
    create(:burm_role, name: "Alexander Hamilton", voice_type: :tenor, role_type: :lead, musical:)
    musical.bulk_roles = "King George III, baritone, lead\nAlexander Hamilton, (tenor), lead"
    musical.save!
    
    assert_equal 2, musical.roles.count
  end

  test "should add new roles from bulk_roles" do
    musical = create(:burm_musical)
    create(:burm_role, name: "King George III", voice_type: :baritone, role_type: :lead,  musical:)
    create(:burm_role, name: "Alexander Hamilton", voice_type: :tenor, role_type: :lead, musical:)
    musical.bulk_roles = "King George III, baritone, lead\nAlexander Hamilton, (tenor), lead\nAaron Burr, baritone, lead"
    musical.save!

    assert_equal 3, musical.roles.count
    assert_equal "Aaron Burr", musical.roles.last.name
  end
end
