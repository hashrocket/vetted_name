require 'rails_helper'

describe 'Query' do
  describe 'performing checks' do
    it 'enqueues checks for all Services' do
      Rails.application.load_seed
      adapter = ActiveJob::Base.queue_adapter

      query = Query.create term: 'hashrocket'

      expect(query.checks.count).to eq 3
      expect(adapter.enqueued_jobs.count).to eq 3
    end
  end
end
