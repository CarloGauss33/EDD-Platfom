require 'httparty'

class Automate::WebhookClient
  def initialize(url, autorization = nil)
    @url = url
    @autorization = autorization
  end

  def post_payload(payload)
    response = post_request(payload)
    handle_response(response)
  end

  private

  def headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@autorization}"
    }
  end

  def post_request(payload)
    HTTParty.post(
      @url,
      body: payload.to_json,
      headers: headers
    )
  end

  def get_request
    HTTParty.get(
      @url,
      headers: headers
    )
  end

  def handle_response(response)
    if response.code.between?(200, 299)
      response
    else
      raise "Webhook Error: #{response.code}"
    end
  end
end
