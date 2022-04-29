# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JurnalApi::Client::SalesOrders do
  let(:client)          { JurnalApi::Client.new }
  let(:module_endpoint) { 'https://sandbox-api.jurnal.id' + '/core/api/v1' + '/sales_orders' }

  describe '#create' do
    context 'successful' do
      let(:dummy_params) do
        read_file_fixture('requests/sales_orders/create_valid.json')
      end
      let(:dummy_response) do
        read_file_fixture('responses/sales_orders/create_success.json')
      end

      before do
        @expected_stub = 
          stub_request(:post, module_endpoint + '.json')
            .with(body: dummy_params.to_json)
            .to_return(status: 201, body: dummy_response.to_json)
      end

      subject { client.sales_order_create(dummy_params.to_json) }

      it 'should hit the expected stub' do
        subject

        expect(@expected_stub).to have_been_requested
      end

      it 'should return a json response' do
        expect(subject).to eq dummy_response
      end
    end
  end

  describe '#convert_to_invoice' do
    context 'successful' do
      let(:dummy_params) do
        read_file_fixture('requests/sales_orders/convert_to_invoice_valid.json')
      end
      let(:dummy_response) do
        read_file_fixture('responses/sales_orders/convert_to_invoice_success.json')
      end

      before do
        @stubbed_id   = 1108 # from Jurnal API documentation
        expected_url  = module_endpoint + '/' + @stubbed_id.to_s + '/convert_to_invoice.json'

        @expected_stub =
          stub_request(:post, expected_url)
            .with(body: dummy_params.to_json)
            .to_return(status: 200, body: dummy_response.to_json)
      end

      subject { client.sales_order_convert_to_invoice(@stubbed_id, dummy_params.to_json) }

      it 'should hit the expected stub' do
        subject

        expect(@expected_stub).to have_been_requested
      end

      it 'should return a json response' do
        expect(subject).to eq dummy_response
      end
    end
  end

  describe '#sales_order_receive_payments' do
    context 'success' do
      let(:dummy_params) do
        {
          page: 1,
          page_size: 5
        }
      end

      let(:dummy_response) do
        read_file_fixture('responses/sales_orders/receive_payments_response.json')
      end

      before do
        expected_url = module_endpoint + '/1/receive_payments.json'

        @expected_stub =
          stub_request(:get, expected_url)
          .with(query: dummy_params)
          .to_return(status: 200, body: dummy_response.to_json)
      end

      subject { client.sales_order_receive_payments(1, dummy_params) }

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
