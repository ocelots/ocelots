require "google/api_client"

Google::APIClient.class_eval do
  def self.build(origin = 'localhost:3000')
    configurations = [
        {
            origin: 'localhost:3000',
            client_id: '1030433741080-bqra8568mng0bfor1u1q5k7iobl2e6bh.apps.googleusercontent.com',
            client_secret: 'u6IrqRnwW7OomwLSVGERssQy',
            redirect_uri: 'http://localhost:3000/home/verify_g_callback'
        },
        {
            origin: 'ocelots-staging.herokuapp.com',
            client_id: '1030433741080-o6q68rkma5vrj64as9omlfur1ii90ftq.apps.googleusercontent.com',
            client_secret: 'abKVdtTIYbXapUkEwQ4Lt9VG',
            redirect_uri: 'http://ocelots-staging.herokuapp.com/home/verify_g_callback'
        },
        {
            origin: 'iocelots.com',
            client_id: '1030433741080.apps.googleusercontent.com',
            client_secret: 'RAQdt17GKweBtQzOCq6Dp965',
            redirect_uri: 'http://www.iocelots.com/home/verify_g_callback'
        }
    ]
    client_configuration = configurations.find{|conf| origin.include?(conf[:origin])}

    client = Google::APIClient.new
    client.authorization.scope = 'https://www.googleapis.com/auth/userinfo.email'
    client.authorization.client_id = client_configuration[:client_id]
    client.authorization.client_secret = client_configuration[:client_secret]
    client.authorization.redirect_uri = client_configuration[:redirect_uri]
    client
  end
end