require "openbd/version"
require 'net/http'
require 'json'

module OpenBD
  class V1
    END_POINT = "http://api.openbd.jp/v1/".freeze

    class << self
      def coverage
        request_url = prepare_url('coverage')
        body = fetch_request request_url
        JSON.parse body
      end

      def get(options)
        request_url = prepare_url('get', options)
        body = fetch_request request_url
        JSON.parse body
      end

      def bulk_get(options)
        # TODO
      end
    end

    private

    # TODO more smart
    def self.log(s)
      puts s
    end

    def self.fetch_request(request_url)
      log("Request URL: #{request_url}")
      response = Net::HTTP.get_response(URI::parse(request_url))
      body = response.body
    end

    def self.prepare_url(method, options = nil)
      if options
        params = "?"
        options.each do |key, val|
          params << "#{key}=#{val}"
        end
        "#{END_POINT}#{method}#{params}"
      else
        "#{END_POINT}#{method}"
      end
    end
  end
end
