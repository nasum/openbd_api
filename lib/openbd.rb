require 'openbd/version'
require 'net/http'
require 'json'

module OpenBD
  API_BASE_URL = 'http://api.openbd.jp/v1/'.freeze

  class << self
    def coverage
      body = send_request('coverage')
      JSON.parse body
    end

    def get(options)
      body = send_request('get', options)
      bibliographes = JSON.parse body

      if bibliographes.size == 1
        bibliographes[0]
      else
        bibliographes.select { |item| item != nil }
      end
    end

    def schema
      body = send_request('schema')
      JSON.parse body
    end

    private

    # TODO more smart
    def self.log(s)
      puts s
    end

    def self.send_request(method, options = nil)
      request_url = prepare_url(method, options)
      log("Request URL: #{request_url}")
      response = Net::HTTP.get_response(URI::parse(request_url))
      body = response.body
    end

    def self.prepare_url(method, options)
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
end
