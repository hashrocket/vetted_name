class BaseCheckJob < ApplicationJob
  def perform(check_id, query_id)
    @check_id = check_id
    @query_id = query_id

    check.update_attributes passed: passed
    QueryChannel.broadcast_to query, { check: check }
  end

  private

  def passed
    raise 'Implement in subclass'
  end

  def check
    Check.find @check_id
  end

  def query
    Query.find @query_id
  end
end
