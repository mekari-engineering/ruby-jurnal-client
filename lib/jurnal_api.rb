require File.expand_path('../jurnal_api/error', __FILE__)
require File.expand_path('../jurnal_api/configuration', __FILE__)
require File.expand_path('../jurnal_api/api', __FILE__)
require File.expand_path('../jurnal_api/client', __FILE__)
require File.expand_path('../jurnal_api/response', __FILE__)

require 'dotenv/load'

module JurnalApi
  extend Configuration

  def self.client(options={})
    JurnalApi::Client.new(options)
  end

  # Delegate to JurnalApi::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to JurnalApi::Client
  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method, include_all) || super
  end
end