require 'faraday'
require File.expand_path('../version', __FILE__)

module JurnalApi
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {JurnalApi::API}
    VALID_OPTIONS_KEYS = [
      :access_token,
      :adapter,
      :api_version,
      :base_url,
      :connection_options,
      :authorization_path,
      :format,
      :user_agent,
      :no_response_wrapper,
      :no_version
    ].freeze

    # By default, don't set a user access token
    DEFAULT_ACCESS_TOKEN = nil

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_URL = 'https://sandbox-api.jurnal.id'.freeze

    DEFAULT_AUTHORIZATION_PATH = 'core'.freeze

    # By default, don't wrap responses with meta data (i.e. pagination)
    DEFAULT_NO_RESPONSE_WRAPPER = false

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is the only available format at this time
    DEFAULT_FORMAT = :json

    DEFAULT_VERSION = 'api/v1'

    # By default, don't wrap responses with meta data (i.e. pagination)


    # An array of valid request/response formats
    #
    # @note Not all methods support the XML format.
    VALID_FORMATS = [:json].freeze

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Jurnal Ruby Gem #{JurnalApi::VERSION}".freeze

    # The api version will be sent to the API endpoint in default
    DEFAULT_NO_VERSION = false

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.access_token        = ENV['JURNAL_COMPANY_API_KEY'] || DEFAULT_ACCESS_TOKEN
      self.adapter             = DEFAULT_ADAPTER
      self.api_version         = DEFAULT_VERSION
      self.authorization_path  = DEFAULT_AUTHORIZATION_PATH
      self.connection_options  = DEFAULT_CONNECTION_OPTIONS
      self.base_url            = ENV['JURNAL_API_BASE_URL'] || DEFAULT_URL
      self.format              = DEFAULT_FORMAT
      self.no_response_wrapper = DEFAULT_NO_RESPONSE_WRAPPER
      self.user_agent          = DEFAULT_USER_AGENT
      self.no_version          = DEFAULT_NO_VERSION
    end
  end
end