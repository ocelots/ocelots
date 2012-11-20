require 'google_oauth'

describe GoogleOauth do
  include GoogleOauth

  describe '#google_client' do
    let(:authorization) { stub 'authorization' }
    let(:client) { stub 'client', authorization: authorization }
    before { Google::APIClient.should_receive(:new).and_return client }

    it "builds google api client using environment variables" do
      [
        ['client_id',     'GOOGLE_OAUTH_CLIENT_ID',     'client_id'],
        ['client_secret', 'GOOGLE_OAUTH_CLIENT_SECRET', 'client_secret'],
        ['redirect_uri',  'GOOGLE_OAUTH_REDIRECT',      'http://domain/redirect']
      ].each do |values|
        m, variable, value = *values
        ENV.should_receive(:[]).with(variable).and_return value
        authorization.should_receive("#{m}=").with value
      end
      authorization.should_receive("scope=").with 'https://www.googleapis.com/auth/userinfo.email'
      google_client
    end
  end
end