module JurnalApi
  class Client
    # Defines methods related to ReceivePayment
    module BankTransfer

      def bank_transfers(params = {})
        response = get('bank_transfers', params)
        response
      end

      def bank_transfer_find(id)
        response = get("bank_transfers/#{id}")
        response
      end

      def bank_transfer_create(params = {})
        response = post('bank_transfers', params)
        response        
      end

      def bank_transfer_update(id, params = {})
        response = put("bank_transfers/#{id}", params)
        response
      end

      def bank_transfer_delete(id)
        response = delete("bank_transfers/#{id}")
        response
      end

    end
  end
end
