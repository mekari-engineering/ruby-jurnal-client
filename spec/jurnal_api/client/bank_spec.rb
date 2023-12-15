# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JurnalApi::Client::SalesInvoices do
  let(:client) { JurnalApi::Client.new }
  let(:module_endpoint) { 'https://sandbox-api.jurnal.id/core/api/v1/' }

  describe '#bank_spec' do
    let(:dummy_response) do
      read_file_fixture('responses/bank/bank_partner_response.json')
    end

    before do
      expected_url = module_endpoint + 'bank_partner.json'

      @expected_stub =
        stub_request(:get, expected_url)
        .to_return(status: 200, body: dummy_response.to_json, headers: header_json)
    end

    subject { client.bank_partners() }

    it 'should hit the expected stub' do
      subject

      expect(@expected_stub).to have_been_requested
    end

    it 'should return a json response' do
      expect(subject).to eq dummy_response
    end
  end
end
