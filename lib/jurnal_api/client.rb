module JurnalApi
  # Wrapper for the JurnalApi REST API
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include JurnalApi::Client::Products
  end
end