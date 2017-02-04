require "openbd/version"
require 'net/http'
require 'json'

module OpenBD
  BASE = "http://api.openbd.jp/".freeze
  class V1
    VERSION = "v1".freeze

    class << self
      def coverage
        request_url = prepare_url(VERSION, 'coverage')
        body = send_request request_url
        return_JSON.parse body
      end

      def get(options)
        request_url = prepare_url(VERSION, 'get', options)
        body = send_request request_url
        bibliographes = JSON.parse body

        if bibliographes.size == 1
          bibliographes[0]
        else
          bibliographes
        end
      end
    end

    private

    # TODO more smart
    def self.log(s)
      puts s
    end

    def self.send_request(request_url)
      log("Request URL: #{request_url}")
      response = Net::HTTP.get_response(URI::parse(request_url))
      body = response.body
    end

    def self.prepare_url(version, method, options = nil)
      if options
        params = ""
        options.each do |key, val|
          params << "#{key}=#{val}"
        end
        "#{BASE}#{version}/#{method}?#{params}"
      else
        "#{BASE}#{version}/#{method}"
      end
    end
  end
end
