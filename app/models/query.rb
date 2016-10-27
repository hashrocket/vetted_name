class Query < ApplicationRecord
  has_many :checks

  after_create :perform_checks

  private

  def perform_checks
    Service.perform_all_checks self
  end
end
