class CheckDomainJob < BaseCheckJob

  private

  def passed
    response_data.available
  end

  def response_data
    @response_data ||= client.registrar.check_domain(ENV['DNSIMPLE_ACCOUNT_ID'], domain).data
  end

  def client
    Dnsimple::Client.new access_token: ENV['DNSIMPLE_ACCESS_TOKEN']
  end

  def domain
    "#{query.term}.com"
  end
end
