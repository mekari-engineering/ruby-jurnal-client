# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JurnalApi::Client::Contacts do
  let(:access_token)    { 'dummytoken123' }
  let(:module_endpoint) { 'https://sandbox-api.jurnal.id/core/api/v1/contacts' }
  let(:client)          { JurnalApi::Client.new(access_token: access_token) }

  describe '#contact_create' do
    let(:dummy_params) do
      {
        person: {
          display_name: 'Elon Musk',
          is_customer:  true,
          people_type:  'customer'
        }
      }
    end

    context 'successful' do
      let(:dummy_response) { read_file_fixture('responses/contacts/create_contact_success_response.json') }

      before do
        @expected_stub = 
          stub_request(:post, "#{module_endpoint}.json")
            .with(headers: { apikey: access_token }, body: dummy_params.to_json)
            .to_return(status: 201, body: dummy_response.to_json, headers: header_json)
      end

      subject { client.contact_create(dummy_params.to_json) }

      it 'should hit the expected stub' do
        subject

        expect(@expected_stub).to have_been_requested
      end

      it 'should return a json response' do
        expect(subject).to eq dummy_response
      end
    end

    context 'failed with status 403' do
      let(:dummy_response) do
        { 'message' => 'Invalid authentication credentials' }
      end

      before do
        @expected_stub = 
          stub_request(:post, "#{module_endpoint}.json")
            .with(headers: { apikey: access_token }, body: dummy_params.to_json)
            .to_return(status: 403, body: dummy_response.to_json, headers: header_json)
      end

      subject { client.contact_create(dummy_params.to_json) }

      it 'should raise a specific error' do
        expect { subject }.to raise_error do |error|
          expect(error).to          be_a(JurnalApi::Forbidden)
          expect(error.message).to  eq "POST #{module_endpoint}.json: 403"
          expect(error.body).to     eq dummy_response
        end

        expect(@expected_stub).to have_been_requested
      end
    end
  end

  describe '#contact_find' do
    context 'successful' do
      let(:dummy_response)  { read_file_fixture('responses/contacts/get_contact_response.json') }
      let(:stubbed_id)      { dummy_response['person']['id'] }

      before do
        @expected_stub =
          stub_request(:get, "#{module_endpoint}/#{stubbed_id}.json")
            .with(headers: { apikey: access_token })
            .to_return(status: 200, body: dummy_response.to_json, headers: header_json)
      end

      subject { client.contact_find(stubbed_id) }

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
