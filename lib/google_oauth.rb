require 'net/http'
require 'google/api_client'

module GoogleOauth
  def google_oauth_url
    google_client.authorization.authorization_uri.to_s
  end

  def verify_google_oauth
    client = google_client
    client.authorization.code = params[:code] if params[:code]
    client.authorization.fetch_access_token!

    http = Net::HTTP.new 'www.googleapis.com', 443
    http.use_ssl = true
    response = http.get "/oauth2/v1/userinfo?access_token=#{client.authorization.access_token}"

    response = JSON.parse response.body
    yield response['email']
  end

  def google_client
    Google::APIClient.new.tap do |client|
      client.authorization.scope = 'https://www.googleapis.com/auth/userinfo.email'
      client.authorization.client_id = ::ENV['GOOGLE_OAUTH_CLIENT_ID']
      client.authorization.client_secret = ::ENV['GOOGLE_OAUTH_CLIENT_SECRET']
      client.authorization.redirect_uri = ::ENV['GOOGLE_OAUTH_REDIRECT']
    end
  end
end