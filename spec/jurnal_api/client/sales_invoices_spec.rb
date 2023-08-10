# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JurnalApi::Client::SalesInvoices do
  let(:client) { JurnalApi::Client.new }
  let(:module_endpoint) { 'https://sandbox-api.jurnal.id/core/api/v1/sales_invoices' }

  describe '#sales_invoice_receive_payments' do
    let(:dummy_params) do
      {
        page: 1,
        page_size: 5
      }
    end
    let(:dummy_response) do
      read_file_fixture('responses/sales_invoices/receive_payments_response.json')
    end

    before do
      expected_url = module_endpoint + '/1/receive_payments.json'

      @expected_stub =
        stub_request(:get, expected_url)
        .with(query: dummy_params)
        .to_return(status: 200, body: dummy_response.to_json)
    end

    subject { client.sales_invoice_receive_payments(1, dummy_params) }

    it 'should hit the expected stub' do
      subject

      expect(@expected_stub).to have_been_requested
    end

    it 'should return a json response' do
      expect(subject).to eq dummy_response
    end
  end
end
