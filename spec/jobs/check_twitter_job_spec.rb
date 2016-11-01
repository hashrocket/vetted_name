require 'rails_helper'

describe CheckTwitterJob do
  let(:service) { FactoryGirl.create :twitter_service }
  let(:query) { FactoryGirl.create :query }
  let(:check) { query.checks.create service: service }

  let(:response) { double(:response, body: body) }

  before do
    allow_any_instance_of(Faraday::Connection).to receive(:get).
      and_return(response)
  end

  context 'with an invalid username' do
    let(:body) { '{"valid":false}' }

    it 'marks the check as not passed and sends a broadcast' do
      expect(QueryChannel).to receive(:broadcast_to).
        with(query, { check: check })
      CheckTwitterJob.perform_now check.id, query.id
      expect(check.reload.passed).to eq false
    end
  end

  context 'with a valid username' do
    let(:body) { '{"valid":true}' }

    it 'marks the check as passed and sends a broadcast' do
      expect(QueryChannel).to receive(:broadcast_to).
        with(query, { check: check })
      CheckTwitterJob.perform_now check.id, query.id
      expect(check.reload.passed).to eq true
    end
  end
end
