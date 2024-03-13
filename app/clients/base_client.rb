require 'net/http'
require 'uri'

class BaseClient
  def initialize(headers:)
    @headers = headers
  end

  def post(path, body: {}, params: {})
    uri = build_uri(path, params)

    request = authorize_request(Net::HTTP::Post.new(uri))
    request.body = body.is_a?(Hash) ? body.to_json : body

    handle_response(make_request(request, uri))
  end

  def get(path, params = {})
    uri = build_uri(path, params)

    request = authorize_request(Net::HTTP::Get.new(uri))
    handle_response(make_request(request, uri))
  end

  private

  def authorize_request(request)
    @headers.each do |key, value|
      request[key] = value
    end
    request
  end

  def make_request(request, uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    http.request(request)
  end

  def build_uri(path, params)
    uri = URI(path)
    uri.query = params.to_query
    uri
  end

  def handle_response(response)
    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)
    else
      raise "Request failed with status: #{response.code} and body: #{response.body}"
    end
  end
end
