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
        when 403
          raise JurnalApi::Forbidden.new error_message_400(response), response[:body]
        when 404
          raise JurnalApi::NotFound, error_message_400(response)
        when 409
          raise JurnalApi::Conflict.new error_message_400(response), response[:body]
        when 422
          raise JurnalApi::UnprocessableEntity.new error_message_400(response), response[:body]
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
    rescue Faraday::ConnectionFailed
      raise JurnalApi::OpenTimeout, 'Jurnal API takes too long to accept connection'
    rescue Faraday::TimeoutError
      raise JurnalApi::ReadTimeout, 'Jurnal API takes too long to render response'
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def error_message_400(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}"
    end

    def error_message_500(response, body=nil)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end