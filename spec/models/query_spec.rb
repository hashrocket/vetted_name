require 'rails_helper'

describe 'Query' do
  describe 'after_create' do
    it 'creates checks for each service' do
      Rails.application.load_seed
      query = Query.create term: 'hashrocket'
      expect(query.checks.count).to eq 3
    end
  end
end
