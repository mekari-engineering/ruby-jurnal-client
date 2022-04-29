# frozen_string_literal: true

module JurnalApi
  class Client
    # Defines methods related to SalesOrders
    module SalesInvoices

      def sales_invoices(params = {})
        response = get('sales_invoices', params)
        response
      end

      def sales_invoice_find(id)
        response = get("sales_invoices/#{id}")
        response
      end

      def sales_invoice_create(params = {})
        response = post('sales_invoices', params)
        response
      end

      def sales_invoice_update(id, params = {})
        response = put("sales_invoices/#{id}", params)
        response
      end

      def sales_invoice_delete(id)
        response = delete("sales_invoices/#{id}")
        response
      end

      def sales_invoice_receive_payments(id, params = {})
        get("sales_invoices/#{id}/receive_payments", params)
      end
    end
  end
end
