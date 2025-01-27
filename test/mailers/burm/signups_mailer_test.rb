require "test_helper"

class BURM::SignupsMailerTest < ActionMailer::TestCase
  test "signup_confirmation" do
    signup = create(:burm_signup, :with_role)
    email = BURM::SignupsMailer.with(signup:).confirmation

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal "BURM | You've signed up to #{signup.musical.title}!", email.subject
    assert_equal [signup.person.email], email.to
  end
end
