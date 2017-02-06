require 'openbd/version'
require 'net/http'
require 'json'

class OpenBD
  API_BASE_URL = 'http://api.openbd.jp/v1/'.freeze

  class << self
    def coverage
      create_body(send_request('coverage'))
    end

    def get(options)
      create_body(send_request('get', options)).select { |item| item != nil }
    end

    def bulk_get(options)
      request_url = prepare_url('get')
      response = Net::HTTP.post_form(URI::parse(request_url), options)
      create_body(response.body).select { |item| item != nil }
    end

    def schema
      create_body(send_request('schema'))
    end
  end

  private

  def self.create_body(body)
    JSON.parse body
  end

  def self.send_request(method, options = nil)
    request_url = prepare_url(method, options)
    response = Net::HTTP.get_response(URI::parse(request_url))
    body = response.body
  end

  def self.prepare_url(method, options = nil)
    if options
      params = ''
      options.each do |key, val|
        params << "#{key}=#{val}"
      end
      "#{API_BASE_URL}#{method}?#{params}"
    else
      "#{API_BASE_URL}#{method}"
    end
  end
end
