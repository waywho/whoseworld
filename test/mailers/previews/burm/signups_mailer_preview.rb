# Preview all emails at http://localhost:3000/rails/mailers/burm/signups_mailer
class BURM::SignupsMailerPreview < ActionMailer::Preview
  def confirmation
    signup = BURM::Signup.last

    BURM::SignupsMailer.with(signup:).confirmation
  end

  def confirm_update
    signup = BURM::Signup.last

    BURM::SignupsMailer.with(signup:).confirm_update
  end
end
