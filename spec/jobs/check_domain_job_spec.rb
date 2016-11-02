require 'rails_helper'

describe CheckDomainJob do
  let(:service) { FactoryGirl.create :domain_service }
  let(:query) { FactoryGirl.create :query }
  let(:check) { query.checks.create service: service }

  let(:client) { double(:client, registrar: registrar) }
  let(:registrar) { double(:registrar, check_domain: domain_check) }
  let(:domain_check) { double(:domain_check, data: data) }

  before do
    allow(Dnsimple::Client).to receive(:new).and_return(client)
  end

  context 'with an available domain' do
    let(:data) { double(:data, available: true) }

    it 'marks the check as passed and sends a broadcast' do
      expect(QueryChannel).to receive(:broadcast_to).
        with(query, { check: check })
      CheckDomainJob.perform_now check.id, query.id
      expect(check.reload.passed).to eq true
    end
  end

  context 'with an unavailable domain' do
    let(:data) { double(:data, available: false) }

    it 'marks the check as not passed and sends a broadcast' do
      expect(QueryChannel).to receive(:broadcast_to).
        with(query, { check: check })
      CheckDomainJob.perform_now check.id, query.id
      expect(check.reload.passed).to eq false
    end
  end
end
