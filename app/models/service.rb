class Service < ApplicationRecord
  has_many :checks

  def self.perform_all_checks(query)
    all.each { |service| service.perform_check query }
  end

  def perform_check(query)
    check = checks.create query: query
    job_klass.constantize.perform_later check.id, query.id
  end
end
