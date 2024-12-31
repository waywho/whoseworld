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

  test "should accept nested attributes for person" do
    signup = build(:burm_signup)
    signup.person_attributes = { first_name: "John", last_name: "Doe", email: "john.doe@test.com" }
    assert signup.save!
    assert signup.person
  end
end
