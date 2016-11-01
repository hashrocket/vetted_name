class CheckTwitterJob < BaseCheckJob

  private

  def passed
    !!check_username
  end

  def check_username
    json = JSON.parse response_body
    json['valid']
  end

  def response_body
    @response_body ||= Faraday.get(url).body
  end

  def url
    "https://twitter.com/users/username_available?username=#{username}"
  end

  def username
    query.term
  end
end
