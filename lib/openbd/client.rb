require 'faraday'
require 'faraday_middleware'
require 'json'

class OpenBD
  API_BASE_URL = 'http://api.openbd.jp/'.freeze
  PATH_TO_GET = 'v1/get'
  PATH_TO_COVERAGE = 'v1/coverage'
  PATH_TO_SCHEMA = 'v1/schema'

  class << self
    def get(isbns)
      response = get_request(PATH_TO_GET, { isbn: normalize_isbns(isbns) })
      response.body
    end

    def bulk_get(isbns)
      response = post_request(PATH_TO_GET, { isbn: isbns })
      response.body
    end

    def coverage
      response = get_request(PATH_TO_COVERAGE)
      response.body
    end

    def schema
      response = get_request(PATH_TO_SCHEMA)
      response.body
    end

    def connection
      Faraday::Connection.new(url: API_BASE_URL) do |connection|
        connection.adapter :net_http
        connection.response :json
      end
    end

    def get_request(method, params = nil)
      faraday_response = connection.get(method, params)
    end

    def post_request(method, params)
      faraday_response = connection.post do |req|
        req.url method
        req.body = "isbn=#{normalize_isbns(params[:isbn])}"
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
