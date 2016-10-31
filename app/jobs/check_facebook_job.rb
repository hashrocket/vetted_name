class CheckFacebookJob < ActiveJob::Base
  queue_as :default

  attr_accessor :check

  def perform(check_id)
    @check = Check.find check_id
    check.update_attributes passed: passed
    QueryChannel.broadcast_to query, { check: check }
  end

  private

  def passed
    !response.success?
  end

  def response
    @response ||= Faraday.get "https://www.facebook.com/#{term}"
  end

  def term
    query.term
  end

  def query
    check.query
  end
end
