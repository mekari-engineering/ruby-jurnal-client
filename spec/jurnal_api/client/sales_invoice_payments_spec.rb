# frozen_string_literal: true

require 'spec_helper'
require 'json'

RSpec.describe JurnalApi::Client::SalesInvoiceReceivePayments do
  let(:client)          { JurnalApi::Client.new }
  let(:dummy_response)  { 'response/sales_invoice_receive_payments/example_data.json' }
  let(:module_endpoint) { 'https://sandbox-api.jurnal.id' + '/core/api/v1' + '/sales_invoices/1/receive_payments' }

  describe '#sales_invoice_receive_payments' do
    context 'successful' do
      before do
        @expected_stub =
          stub_request(:get, module_endpoint + '.json')
          .to_return(status: 201, body: dummy_response.to_json)
      end

      subject { client.sales_invoice_receive_payments(sample_id) }

      it 'should hit the expected stub' do
        subject

        expect(@expected_stub).to have_been_requested
      end

      it 'should return a json response' do
        expect(subject).to eq dummy_response
      end
    end
  end
end
