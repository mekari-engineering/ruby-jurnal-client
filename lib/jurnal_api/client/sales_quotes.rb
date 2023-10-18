# frozen_string_literal: true

module JurnalApi
  class Client
    # Defines methods related to SalesQuotes
    module SalesQuotes
      def sales_quotes(params = {})
        get('sales_quotes', params)
      end

      def sales_quote_find(id)
        get("sales_quotes/#{id}")
      end
    end
  end
end
