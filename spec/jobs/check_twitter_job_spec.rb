require 'rails_helper'

describe CheckTwitterJob do
  let(:service) { FactoryGirl.create :twitter_service }
  let(:query) { FactoryGirl.create :query }
  let(:check) { query.checks.create service: service }

  context 'with an invalid username' do
    it 'marks the check as not passed and sends a broadcast' do
      allow(Twitter::REST::Client).to receive(:new).
        and_raise(Twitter::Error::NotFound)
      expect(QueryChannel).to receive(:broadcast_to).
        with(query, { check: check })
      CheckTwitterJob.perform_now check.id, query.id
      expect(check.reload.passed).to eq false
    end
  end

  context 'with a valid username' do
    it 'marks the check as passed and sends a broadcast' do
      client = double(:client, user: true)
      allow(Twitter::REST::Client).to receive(:new).
        and_return(client)
      expect(QueryChannel).to receive(:broadcast_to).
        with(query, { check: check })
      CheckTwitterJob.perform_now check.id, query.id
      expect(check.reload.passed).to eq true
    end
  end
end
