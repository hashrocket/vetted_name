class Query < ApplicationRecord
  has_many :checks

  after_create :create_checks

  def as_json(*_)
    {
      term: term,
      checks: checks
    }
  end

  private

  def create_checks
    Service.all.each { |service| service.checks.create query: self }
  end
end
