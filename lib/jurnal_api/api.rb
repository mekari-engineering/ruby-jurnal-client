require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)

module JurnalApi
  # @private
  class API
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS
    attr_reader :endpoint

    # Creates a new API
    def initialize(options={})
      options = JurnalApi.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end

    def endpoint
      # certain endpoint don't need authorization_path
      #   ex: /api/v1/contacts
      if authorization_path.empty?
        return "#{base_url}/#{api_version}"
      end

      "#{base_url}/#{authorization_path}/#{api_version}"
    end

    include Connection
    include Request
  end
end