module JurnalApi
  class Client
    # Defines methods related to Bank
    module Bank
      def bank_partners()
        get('bank_partner')
      end
    end
  end
end
