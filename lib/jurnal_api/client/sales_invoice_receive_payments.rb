# frozen_string_literal: true

module JurnalApi
  class Client
    # Defines methods related to ReceivePayments from SalesInvoice
    module SalesInvoiceReceivePayments
      def sales_invoice_receive_payments(id, params = {})
        get("sales_invoices/#{id}/receive_payments", params)
      end
    end
  end
end
