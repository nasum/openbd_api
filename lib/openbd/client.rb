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
      response = Net::HTTP.post_form(URI::parse(request_url), isbn: normalize_isbns(isbns))
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
      case isbns
      when String
        params = normalize_isbns(isbns)
        "#{API_BASE_URL}#{method}?isbn=#{params}"
      when Numeric
        params = normalize_isbns(isbns)
        "#{API_BASE_URL}#{method}?isbn=#{params}"
      when Array
        params = normalize_isbns(isbns)
        "#{API_BASE_URL}#{method}?isbn=#{params}"
      else
        "#{API_BASE_URL}#{method}"
      end
    end

    def normalize_isbns(isbns)
      case isbns
      when String
        isbns
      when Numeric
        isbns
      when Array
        params = ""
        isbns.each do |isbn|
          params << "#{isbn}, "
        end
        params.strip!.gsub(/,$/,'')
      end
    end
  end
end
