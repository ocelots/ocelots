require 'spec_helper'

describe Google::APIClient do
  describe :build do
    it 'builds google api client for localhost' do
      client = Google::APIClient.build
      client.authorization.redirect_uri.to_s.should == 'http://localhost:3000/home/verify_g_callback'
    end

    #it 'builds google api client for staging' do
    #  client = Google::APIClient.build
    #  client.authorization.redirect_uri.to_s.should == 'http://ocelots-staging.herokuapp.com/home/verify_g_callback'
    #end
    #
    #it 'builds google api client for production' do
    #  client = Google::APIClient.build
    #  client.authorization.redirect_uri.to_s.should == 'http://iocelots.com/home/verify_g_callback'
    #end
  end
end