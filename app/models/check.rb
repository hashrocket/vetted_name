class Check < ApplicationRecord
  belongs_to :query
  belongs_to :service

  def as_json(*_)
    {
      id: id,
      name: service.name,
      passed: passed
    }
  end

  def perform_job
    service.job_klass.constantize.perform_later id, query.id
  end
end
