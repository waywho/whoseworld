Recaptcha.configure do |config|
  config.site_key  = Rails.application.credentials.dig(:recaptcha_3, :site_key)
  config.secret_key = Rails.application.credentials.dig(:recaptcha_3, :site_secret)
end
