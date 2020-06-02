require 'faraday_middleware'

Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module JurnalApi
  # @private
  module Connection
    private

    def connection(raw = false)
      basic_headers = {
        'Accept'      => "application/#{format}; charset=utf-8",
        'User-Agent'  => user_agent
      }

      options = { headers: basic_headers, url: endpoint }.merge(connection_options)

      Faraday::Connection.new(options) do |connection|
        case authorization_path
        when 'partner/core'
          connection.headers['Authorization'] = "Bearer #{access_token}"
        when 'core'
          connection.headers['apikey'] = "#{access_token}"
        end

        connection.use Faraday::Request::UrlEncoded
        unless raw
          case format.to_s.downcase
            when 'json' then connection.use FaradayMiddleware::ParseJson
          end
        end

        connection.use FaradayMiddleware::RaiseHttpException
        connection.adapter(adapter)
      end
    end
  end
end