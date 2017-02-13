module OpenBD
  class Client
    API_BASE_URL = 'http://api.openbd.jp/'.freeze
    PATH_TO_GET = 'v1/get'
    PATH_TO_COVERAGE = 'v1/coverage'
    PATH_TO_SCHEMA = 'v1/schema'

    def get(isbns)
      get_request(
        method: PATH_TO_GET,
        params: { isbn: normalize_isbns(isbns) },
        response_class: ::OpenBD::Responses::Get
      )
    end

    def bulk_get(isbns)
      get_request(
        method: PATH_TO_GET,
        params: { isbn: normalize_isbns(isbns) },
        response_class: ::OpenBD::Responses::Get
      )
    end

    def coverage
      get_request(
        method: PATH_TO_COVERAGE,
        params: nil,
        response_class: ::OpenBD::Responses::Coverage
      )
    end

    def schema
      get_request(
        method: PATH_TO_SCHEMA,
        params: nil,
        response_class: ::OpenBD::Responses::Schema
      )
    end

    def connection
      @connection ||= ::Faraday::Connection.new(url: API_BASE_URL) do |connection|
        connection.adapter :net_http
        connection.response :json
      end
    end

    def get_request(method:, params:, response_class:)
      faraday_response = connection.get(method, params)
      response_class.new(faraday_response)
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
        isbns.to_s
      when Array
        isbns.join(",")
      end
    end
  end
end
