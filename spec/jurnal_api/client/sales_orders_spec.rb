# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JurnalApi::Client::SalesOrders do
  let(:client)          { JurnalApi::Client.new }
  let(:module_endpoint) { 'https://sandbox-api.jurnal.id/core/api/v1/sales_orders' }

  describe '#get' do
    context 'successful' do
      let(:dummy_response) { read_file_fixture('responses/sales_orders/create_success.json') }
      let(:sales_order_id) { dummy_response['sales_order']['id'] }
      let(:dummy_params) { { for_internal: true } }

      before do
        @expected_stub = stub_request(:get, "#{module_endpoint}/#{sales_order_id}.json")
          .with(query: dummy_params)
          .to_return(status: 200, body: dummy_response.to_json, headers: header_json)
      end

      subject { client.sales_order_find(sales_order_id, dummy_params) }

      it 'should hit the expected stub' do
        subject

        expect(@expected_stub).to have_been_requested
      end

      it 'should return a json response' do
        expect(subject).to eq dummy_response
      end
    end

    context 'failed' do
      context 'with status 503' do
        let(:dummy_response) { read_file_fixture('responses/sales_orders/create_success.json') }
        let(:sales_order_id) { dummy_response['sales_order']['id'] }

        before do
          @expected_stub = stub_request(:get, "#{module_endpoint}/#{sales_order_id}.json")
            .to_return(
              status: 503,
              body: 'upstream connect error or disconnect/reset before headers. reset reason: connection termination',
            )
        end

        subject { client.sales_order_find(sales_order_id) }

        it 'should hit the expected stub' do
          expect { subject }.to raise_error JurnalApi::ServiceUnavailable

          expect(@expected_stub).to have_been_requested
        end
      end
    end
  end

  describe '#get so link' do
    context 'successful' do
      let(:dummy_response) do
        { 'url' => 'http://dummy.com/123456' }
      end
      let(:sales_order_id) { '1234' }

      before do
        @expected_stub = stub_request(:get, "#{module_endpoint}/#{sales_order_id}/register_tiny_url.json")
          .to_return(status: 200, body: dummy_response.to_json, headers: header_json)
      end

      subject { client.sales_order_link(sales_order_id) }

      it 'should hit the expected stub' do
        subject

        expect(@expected_stub).to have_been_requested
      end

      it 'should return a json response' do
        expect(subject).to eq dummy_response
      end
    end
  end

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
            .to_return(status: 201, body: dummy_response.to_json, headers: header_json)
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

  describe '#update' do
    context 'successful' do
      let(:dummy_params) do
        read_file_fixture('requests/sales_orders/create_valid.json')
      end
      let(:dummy_response) do
        read_file_fixture('responses/sales_orders/create_success.json')
      end
      let(:so_id) { 909 }

      before do
        @expected_stub =
          stub_request(:patch, "#{module_endpoint}/#{so_id}.json")
          .with(body: dummy_params.to_json)
          .to_return(status: 201, body: dummy_response.to_json, headers: header_json)
      end

      subject { client.sales_order_update(so_id, dummy_params.to_json) }

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
            .to_return(status: 200, body: dummy_response.to_json, headers: header_json)
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
        expected_url = module_endpoint + '/1/sales_order_payments.json'

        @expected_stub =
          stub_request(:get, expected_url)
          .with(query: dummy_params)
          .to_return(status: 200, body: dummy_response.to_json, headers: header_json)
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
