class TestController < ApplicationController
  skip_before_filter :require_login, :only => :test_login

  def test_login
    if Rails.env.test? || Rails.env.development?
      session[:email] = "test@gmail.com"
      redirect_to "/"
    end
  end
end
