require "openbd/version"
require 'net/http'
require 'json'

module OpenBD
  API_BASE_URL = "http://api.openbd.jp/".freeze
  class V1
    VERSION = "v1".freeze

    class << self
      def coverage
        body = send_request(VERSION, 'coverage')
        JSON.parse body
      end

      def get(options)
        body = send_request(VERSION, 'get', options)
        bibliographes = JSON.parse body

        if bibliographes.size == 1
          bibliographes[0]
        else
          bibliographes.select { |item| item != nil }
        end
      end

      def schema
        body = send_request(VERSION, 'schema')
        JSON.parse body
      end
    end

    private

    # TODO more smart
    def self.log(s)
      puts s
    end

    def self.send_request(version, method, options = nil)
      request_url = prepare_url(version, method, options)
      log("Request URL: #{request_url}")
      response = Net::HTTP.get_response(URI::parse(request_url))
      body = response.body
    end

    def self.prepare_url(version, method, options)
      if options
        params = ""
        options.each do |key, val|
          params << "#{key}=#{val}"
        end
        "#{API_BASE_URL}#{version}/#{method}?#{params}"
      else
        "#{API_BASE_URL}#{version}/#{method}"
      end
    end
  end
end
