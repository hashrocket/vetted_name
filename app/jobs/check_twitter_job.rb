class CheckTwitterJob < BaseCheckJob

  private

  def passed
    begin
      client.user username
      false
    rescue Twitter::Error::NotFound
      true
    end
  end

  def username
    query.term
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
  end
end
