require 'openbd/version'
require 'net/http'
require 'json'

class OpenBD
  API_BASE_URL = 'http://api.openbd.jp/v1/'.freeze

  class << self
    def get(isbns)
      request_url = prepare_url('get', isbns)
      response = Net::HTTP.get_response(URI::parse(request_url))
      create_body(response).select { |item| item != nil }
    end

    def bulk_get(isbns)
      request_url = prepare_url('get')
      response = Net::HTTP.post_form(URI::parse(request_url), isbn: isbns)
      create_body(response).select { |item| item != nil }
    end

    def coverage
      request_url = prepare_url('coverage')
      response = Net::HTTP.get_response(URI::parse(request_url))
      create_body(response)
    end

    def schema
      request_url = prepare_url('schema')
      response = Net::HTTP.get_response(URI::parse(request_url))
      create_body(response)
    end

    def create_body(response)
      JSON.parse response.body
    end

    def prepare_url(method, isbns = nil)
      if isbns.kind_of? String
        params = "isbn=#{isbns}"
        "#{API_BASE_URL}#{method}?#{params}"
      elsif isbns.kind_of? Array
        params = "isbn="
        isbns.each do |isbn|
          params << "#{isbn}, "
        end
        params.strip!.gsub!(/,$/,'')
        "#{API_BASE_URL}#{method}?#{params}"
      else
        "#{API_BASE_URL}#{method}"
      end
    end
  end
end
