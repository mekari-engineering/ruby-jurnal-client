require 'faraday'

# @private
module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          raise JurnalApi::BadRequest, error_message_400(response)
        when 404
          raise JurnalApi::NotFound, error_message_400(response)
        when 429
          raise JurnalApi::TooManyRequests, error_message_400(response)
        when 500
          raise JurnalApi::InternalServerError, error_message_500(response, "Something is went wrong.")
        when 502
          raise JurnalApi::BadGateway, error_message_500(response, "Bad gateway.")
        when 503
          raise JurnalApi::ServiceUnavailable, error_message_500(response, "Jurnal is rate limiting your requests.")
        when 504
          raise JurnalApi::GatewayTimeout, error_message_500(response, "504 Gateway Time-out")
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def error_message_400(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{error_body(response[:body])}"
    end

    def error_body(body)
      # body gets passed as a string, not sure if it is passed as something else from other spots?
      if not body.nil? and not body.empty? and body.kind_of?(String)
        # removed multi_json thanks to wesnolte's commit
        body = ::JSON.parse(body)
      end
    end

    def error_message_500(response, body=nil)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end