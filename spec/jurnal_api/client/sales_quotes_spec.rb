# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JurnalApi::Client::SalesQuotes do
  let(:client)          { JurnalApi::Client.new }
  let(:module_endpoint) { 'https://sandbox-api.jurnal.id' + '/core/api/v1' + '/sales_quotes' }

  describe '#get_list' do
    context 'successful' do
      let(:dummy_response) { read_file_fixture('responses/sales_quotes/list_success.json') }

      before do
        @expected_stub = stub_request(:get, "#{module_endpoint}.json")
          .to_return(status: 200, body: dummy_response.to_json, headers: header_json)
      end

      subject { client.sales_quotes }

      it 'should hit the expected stub' do
        subject

        expect(@expected_stub).to have_been_requested
      end

      it 'should return a json response' do
        expect(subject).to eq dummy_response
      end
    end
  end

  describe '#get' do
    context 'successful' do
      let(:dummy_response) { read_file_fixture('responses/sales_quotes/create_success.json') }
      let(:sales_quote_id) { dummy_response['sales_quote']['id'] }

      before do
        @expected_stub = stub_request(:get, "#{module_endpoint}/#{sales_quote_id}.json")
          .to_return(status: 200, body: dummy_response.to_json, headers: header_json)
      end

      subject { client.sales_quote_find(sales_quote_id) }

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
