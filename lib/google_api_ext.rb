require "google/api_client"

Google::APIClient.class_eval do
  def self.build
    client = Google::APIClient.new
    client.authorization.client_id = '83201658099-d921h8ub8ugrus8j1l923m2ke98h2lo1.apps.googleusercontent.com'
    client.authorization.client_secret = 'A6_wExaNj5_C0QdSF1zZJ4bB'
    client.authorization.scope = 'https://www.googleapis.com/auth/userinfo.email'
    client.authorization.redirect_uri = 'http://iocelots.com/verify_g_callback'
    client
  end
end