require "test_helper"

class BURM::SignupTest < ActiveSupport::TestCase
  test "should belong to a person" do
    signup = BURM::Signup.new
    assert_not signup.save
    assert_equal ["must exist"], signup.errors.messages[:person]
  end

  test "should belong to a role" do
    signup = BURM::Signup.new
    assert_not signup.save
    assert_equal ["must exist"], signup.errors.messages[:role]
  end

  test "should belong to a musical" do
    signup = BURM::Signup.new
    assert_not signup.save
    assert_equal ["must exist"], signup.errors.messages[:musical]
  end

  test "should only allow one signup per person, per musical and role" do
    person = create(:burm_person)
    musical = create(:burm_musical)
    role = create(:burm_role, musical: musical)
    signup = create(:burm_signup, person: person, musical: musical, role: role)
    signup = build(:burm_signup, person: person, musical: musical, role: role)
    assert_not signup.valid?
    assert_equal ["has already been taken"], signup.errors.messages[:person]
  end

  test "should cache person name, role name, and musical title" do
    signup = create(:burm_signup)
    assert_equal signup.person.full_name, signup.person_name
    assert_equal signup.role.name, signup.role_name
    assert_equal signup.musical.title, signup.musical_title
  end

  test "should accept nested attributes for person" do
    signup = build(:burm_signup)
    signup.person_attributes = { first_name: "John", last_name: "Doe", email: "john.doe@test.com" }
    assert signup.save!
    assert signup.person
  end
end
