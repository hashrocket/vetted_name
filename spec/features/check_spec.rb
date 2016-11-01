require 'rails_helper'

describe 'checking a name', js: true do
  let!(:service) do
    Service.create name: 'Twitter', job_klass: 'CheckTwitterJob'
  end

  let(:response) { double(:response, body: body) }

  before do
    allow_any_instance_of(Faraday::Connection).to receive(:get).
      and_return(response)
  end

  context 'with an available name' do
    let(:body) { '{"valid":true}' }

    it 'shows passed checks' do
      term = 'washrocket'
      perform_enqueued_jobs do
        visit "/check/#{term}"
      end

      input_value = find(:css, 'input').value
      expect(input_value).to eq term
      expect(page).to have_selector('.passed', text: service.name)
    end
  end

  context 'with an unavailable name' do
    let(:body) { '{"valid":false}' }

    it 'shows failed checks' do
      term = 'hashrocket'
      perform_enqueued_jobs do
        visit "/check/#{term}"
      end

      input_value = find(:css, 'input').value
      expect(input_value).to eq term
      expect(page).to have_selector('.failed', text: service.name)
    end
  end
end
