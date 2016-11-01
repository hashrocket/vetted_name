class ApplicationJob < ActiveJob::Base
  queue_as :default

  rescue_from(Faraday::ConnectionFailed) do
    check.update_attributes passed: false
    QueryChannel.broadcast_to query, { check: check }
  end
end
