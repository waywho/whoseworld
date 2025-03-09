class BatchMailClient < Mailtrap::Client
  def initialize(**params)
    config = {
      api_key: Rails.application.credentials.mailtrap_api_token
    }
    super(**params.merge(config))
  end

  def send_batch(base, mails)
    request_body = {
      base: base,
      requests: mails.map(&:as_json)
    }
    request = post_request(request_url, request_body.to_json)
    response = http_client.request(request)

    handle_response(response)
  end

  private

  def request_url
    "/api/batch"
  end
end

