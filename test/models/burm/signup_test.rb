# frozen_string_literal: true

require "test_helper"

class BURM::SignupTest < ActiveSupport::TestCase
  test "should belong to a person" do
    signup = BURM::Signup.new

    assert_not signup.valid?
    assert_equal ["can't be blank"], signup.errors.messages[:person]
  end

  test "should belong to a role" do
    signup = BURM::Signup.new
    assert_not signup.valid?
    assert_equal ["can't be blank"], signup.errors.messages[:role]
  end

  test "should belong to a musical" do
    signup = BURM::Signup.new
    assert_not signup.valid?
    assert_equal ["can't be blank"], signup.errors.messages[:musical]
  end

  test "should only allow signups for open musical" do
    musical = create(:burm_musical, signup_start_at: Time.current + 1.day)
    signup = build(:burm_signup, musical: musical)

    assert_not signup.valid?
    assert_equal ["is not open for signups"], signup.errors.messages[:musical]
  end

  test "should only allow one signup per person, per musical and role" do
    person = create(:burm_person)
    musical = create(:burm_musical)
    role = create(:burm_role, musical:)
    create(:burm_signup, person:, musical:, role:)

    signup = build(:burm_signup, person:, musical:, role:)

    assert_not signup.valid?
    assert_equal ["cannot sign up for the same role and musical twice"], signup.errors.messages[:person]
  end

  test "should find or build person" do
    signup = build(:burm_signup, :with_role)
    assert signup.save!
    assert signup.person
  end

  test "should cache person name, role name, and musical title" do
    signup = create(:burm_signup, :with_role)
    assert_equal signup.person.full_name, signup.person_name
    assert_equal signup.role.name, signup.role_name
    assert_equal signup.musical.title, signup.musical_title
  end

  test "should accept nested attributes for person" do
    signup = build(:burm_signup, :with_role)
    signup.person_attributes = { first_name: "John", last_name: "Doe", email: "john.doe@test.com" }
    assert signup.save!
    assert signup.person
  end

  test "automatically assigned role to signup" do
    signup = create(:burm_signup, :with_role)
    assert signup.burm_role_id, signup.assigned_burm_role_id
  end

  test "only allow role to be assigned to unique signup" do
    musical = create(:burm_musical)
    role = create(:burm_role, musical:)
    role_2 = create(:burm_role, musical:)
    signup = create(:burm_signup, role:, musical:)
    signup_2 = create(:burm_signup, role: role_2, musical:)
    signup_2.assigned_role = signup.assigned_role

    assert_not signup_2.valid?
  end
end
