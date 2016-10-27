class Query < ApplicationRecord
  has_many :checks

  after_create :perform_checks

  def as_json(*_)
    {
      term: term,
      checks: checks
    }
  end

  private

  def perform_checks
    Service.perform_all_checks self
  end
end
