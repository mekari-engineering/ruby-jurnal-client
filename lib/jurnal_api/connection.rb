require 'faraday_middleware'

Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module JurnalApi
  # @private
  module Connection
    private

    def connection(raw = false)
      basic_headers = {
        'Accept'        => "application/#{format}; charset=utf-8",
        'User-Agent'    => user_agent,
        'Content-Type'  => "application/json"
      }

      options = { headers: basic_headers, url: endpoint }.merge(connection_options)

      Faraday::Connection.new(options) do |connection|
        # SET middlewares first
        connection.request    :multipart
        connection.request    :url_encoded
        connection.response   :logger
        connection.use        FaradayMiddleware::RaiseHttpException
        connection.use        Faraday::Request::UrlEncoded

        unless raw
          case format.to_s.downcase
            when 'json'
              connection.use(FaradayMiddleware::ParseJson, :content_type => /\bjson$/)
          end
        end

        # ...then the adapter
        # this is to maintain the API of Faraday v1
        connection.adapter adapter

        case authorization_path
        when 'partner/core'
          connection.headers['Authorization'] = "Bearer #{access_token}"
        when 'core', '', nil
          connection.headers['apikey'] = "#{access_token}"
        end
      end
    end
  end
end