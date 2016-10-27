class Check < ApplicationRecord
  belongs_to :query
  belongs_to :service
end
