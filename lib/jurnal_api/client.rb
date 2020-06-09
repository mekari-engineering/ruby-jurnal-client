module JurnalApi
  # Wrapper for the JurnalApi REST API
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include JurnalApi::Client::JournalEntries
    include JurnalApi::Client::Products
    include JurnalApi::Client::RecurringSchedules
    include JurnalApi::Client::ReceivePayment
    include JurnalApi::Client::SalesOrderPayments
    include JurnalApi::Client::SalesOrders
  end
end