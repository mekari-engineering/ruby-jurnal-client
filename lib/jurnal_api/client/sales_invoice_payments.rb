# frozen_string_literal: true

module JurnalApi
  class Client
    # Defines methods related to ReceivePayments from SalesInvoice
    module SalesInvoicePayments

      def sales_invoice_payments(id, params = {})
        response = get("sales_invoices/#{id}/receive_payments", params)
        response
      end

    end
  end
end
