module JurnalApi
  class Client
    # Defines methods related to ReceivePayment
    module ReceivePayment

      def receive_payments(params = {})
        response = get('receive_payments', params)
        response
      end

      def receive_payment_find(id)
        response = get("receive_payments/#{id}")
        response
      end

      def receive_payment_create(params = {})
        response = post('receive_payments', params)
        response        
      end

      def receive_payment_update(id, params = {})
        response = put("receive_payments/#{id}", params)
        response
      end

      def receive_payment_delete(id)
        response = delete("receive_payments/#{id}")
        response
      end

    end
  end
end
