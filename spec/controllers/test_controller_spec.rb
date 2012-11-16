require 'spec_helper'

describe TestController do

  describe :test_login do
    it 'ensure person login with test email if Rails environment is test' do
      get :test_login
      session[:email] == 'test@gmail.com'
      assert_redirected_to '/'
    end
  end
end
