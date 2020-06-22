module JurnalApi
  class Client
    # Defines methods related to SalesOrders
    module Customers

      def customers(params = {})
        response = get('customers', params)
        response
      end

      def customer_find(id)
        response = get("customers/#{id}")
        response
      end

      def customer_create(params = {})
        response = post('customers', params)
        response        
      end

      def customer_update(id, params = {})
        response = put("customers/#{id}", params)
        response
      end

      def customer_delete(id)
        response = delete("customers/#{id}")
        response
      end

    end
  end
end
