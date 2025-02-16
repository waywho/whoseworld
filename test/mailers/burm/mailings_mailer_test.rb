require "test_helper"

class BURM::MailingsMailerTest < ActionMailer::TestCase
  test "new_subscription" do
    person = create(:burm_person)
    email = BURM::MailingsMailer.with(person: person).new_subscription

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal "BURM | Confirm your subscription!", email.subject
    assert_equal [person.email], email.to
  end
end
