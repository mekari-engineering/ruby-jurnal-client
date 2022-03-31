# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JurnalApi::Client::HealthChecks do
  let(:client)          { JurnalApi::Client.new(api_version: '') }
  let(:module_endpoint) { 'https://sandbox-api.jurnal.id' + '/core' + '/ping/health_check' }

  describe '#check' do
    context 'successful' do
      let(:dummy_response) do
        'I am alive!\n'
      end

      before do
        @expected_stub = 
          stub_request(:get, module_endpoint + '.json')
            .to_return(status: 200, body: dummy_response)
      end

      subject { client.health_check }

      it 'should hit the expected stub' do
        subject

        expect(@expected_stub).to have_been_requested
      end

      it 'should return a string response' do
        expect(subject.body).to eq dummy_response
      end
    end
  end
end
