module JurnalApi
  class Client
    # Defines methods related to Bank
    module Bank
      def bank_partners(params = {})
        get('bank_partner', params)
      end
    end
  end
end
