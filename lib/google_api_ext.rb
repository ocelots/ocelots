require "google/api_client"

Google::APIClient.class_eval do
  def self.build
    client = Google::APIClient.new
    client.authorization.scope = 'https://www.googleapis.com/auth/userinfo.email'
    client.authorization.client_id = ENV['GOOGLE_OAUTH_CLIENT_ID ']
    client.authorization.client_secret = ENV['GOOGLE_OAUTH_CLIENT_SECRET ']
    client.authorization.redirect_uri = ENV['GOOGLE_OAUTH_REDIRECT ']
    client
  end
end