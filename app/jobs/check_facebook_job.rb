class CheckFacebookJob < BaseCheckJob

  private

  def passed
    !response.success?
  end

  def response
    @response ||= Faraday.get "https://www.facebook.com/#{username}"
  end

  def username
    query.term
  end
end
