module JurnalApi
  # Custom error class for rescuing from all Jurnal errors
  class Error < StandardError; end
  class ErrorWithBody < Error
    attr_reader :body

    def initialize(msg = "", body = {})
      @body = body

      super(msg)
    end    
  end

  # Raised when Jurnal returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Jurnal returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Jurnal returns the HTTP status code 409
  class Conflict < ErrorWithBody; end

  # Raised when Jurnal returns the HTTP status code 422
  class UnprocessableEntity < ErrorWithBody; end

  # Raised when Jurnal returns the HTTP status code 429
  class TooManyRequests < Error; end

  # Raised when Jurnal returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Jurnal returns the HTTP status code 502
  class BadGateway < Error; end

  # Raised when Jurnal returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when Jurnal returns the HTTP status code 504
  class GatewayTimeout < Error; end

  # Raised when a subscription payload hash is invalid
  class InvalidSignature < Error; end

  # Raised when Jurnal returns the HTTP status code 429
  class RateLimitExceeded < Error; end
end