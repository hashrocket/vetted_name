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
end
