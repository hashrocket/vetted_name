require 'rails_helper'

describe 'checking a name', js: true do
  let!(:service) do
    Service.create name: 'Twitter', job_klass: 'CheckTwitterJob'
  end

  context 'with an available name' do
    it 'shows passed checks' do
      client = double(:client, user: true)
      allow(Twitter::REST::Client).to receive(:new).
        and_return(client)

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
    it 'shows failed checks' do
      allow(Twitter::REST::Client).to receive(:new).
        and_raise(Twitter::Error::NotFound)

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
