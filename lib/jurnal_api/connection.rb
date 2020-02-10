require 'faraday_middleware'

Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module JurnalApi
  # @private
  module Connection
    private

    def connection(raw = false)
      options = {
        :headers => {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent},
        :url => "#{endpoint}#{authorization_path}/api/v1/",
      }.merge(connection_options)

      Faraday::Connection.new(options) do |connection|
        connection.headers['Authorization'] = "Bearer #{access_token}" if authorization_path == 'partner/core'
        connection.headers['apikey'] = "#{access_token}" if authorization_path == 'core'

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