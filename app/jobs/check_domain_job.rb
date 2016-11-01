class CheckDomainJob < BaseCheckJob

  private

  def passed
    !response.success?
  end

  def response
    @response ||= Faraday.get "http://#{domain}.com"
  end

  def domain
    query.term
  end
end
