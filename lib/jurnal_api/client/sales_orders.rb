module JurnalApi
  class Client
    # Defines methods related to SalesOrders
    module SalesOrders

      def sales_orders(params = {})
        response = get('sales_orders', params)
        response
      end

      def sales_order_find(id)
        response = get("sales_orders/#{id}")
        response
      end

      def sales_order_create(params = {})
        response = post('sales_orders', params)
        response        
      end

      def sales_order_convert(id, params = {})
        response = post("sales_orders/#{id}/convert_to_invoice", params)
        response
      end

    end
  end
end