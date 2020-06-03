# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JurnalApi::Client::SalesOrders do
  let(:client) { JurnalApi::Client.new }

  describe '#create' do
    let(:dummy_params) do
      JSON.parse(read_file_fixture('requests/sales_orders/create_valid.json'))
    end

    let(:dummy_response) do
      read_file_fixture('responses/sales_orders/create_success.json')
    end

    subject { client.sales_order_create(dummy_params) }

    before do
      @expected_stub = 
        stub_request(:post, 'https://sandbox-api.jurnal.id' + '/core/api/v1' + '/sales_orders.json')
          .with(body: dummy_params)
          .to_return(status: 201, body: dummy_response)
    end

    it 'should hit the expected stub' do
      subject

      expect(@expected_stub).to have_been_requested
    end

    it 'should return a json response' do
      expect(subject).to eq JSON.parse(dummy_response)
    end
  end
end
