module Recaptchable
  extend ActiveSupport::Concern

  private

  def recaptcha_action
    @recaptcha_action ||= params[:recaptcha_action]
  end

  def verify_captcha
    return if verify_recaptcha(action: recaptcha_action, minimum_score: 0.8)

    reintialize_record

    score = recaptcha_reply["score"]
    Rails.logger.warn("Denied signup because of a recaptcha score of #{score}")
    Rails.logger.warn("Recaptcha reply: #{recaptcha_reply}")

    render :edit
  end

  def reintialize_record
    rails NotImplementedError, "You must implement the reintialize_record method in the controller"
  end
end
