module JurnalApi
  class Client
    # Defines methods related to SalesOrderPayments
    module SalesOrderPayments

      def sales_order_payments(params = {})
        response = get('sales_order_payments', params)
        response
      end

      def sales_order_payments_find(id)
        response = get("sales_order_payments/#{id}")
        response
      end

      def sales_order_payment_create(params = {})
        response = post('sales_order_payments', params)
        response        
      end

    end
  end
end