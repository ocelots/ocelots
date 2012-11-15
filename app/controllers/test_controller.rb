class TestController < ApplicationController
  skip_before_filter :require_login, :only => :test_login

  def test_login
    if Rails.env.test?
      @current_person = test_sign_in
      redirect_to "/teams"
    end
  end

  def test_sign_in
    Person.create!(email: "test@gmail.com", full_name: 'Test Person', account: 'test_account')
  end
end
