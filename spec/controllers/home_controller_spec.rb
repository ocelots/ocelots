require 'spec_helper'

describe HomeController do
  render_views

  describe :index do
    it 'renders landing page if user has not signed in' do
      get :index
      response.should be_success
      response.body.should =~ /A community for team members./
      #response.body.should =~ /Please choose a approach to sign in./
    end

    it 'includes a button to sign in with Mozilla Persona' do
      get :index
      response.should be_success
      #response.body.should =~ /Login with Persona/
      #response.body.should =~ /Login with Weibo/
      assert_select '#authenticate','Persona'
    end

    it 'does not allow click other place except sign in buttons'
  end
end