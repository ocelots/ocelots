require 'spec_helper'

describe ApplicationController do
  let(:session) { {} }
  let(:params) { {} }
  let(:request) { stub 'request' }
  let(:person) { stub 'person' }

  before do
    controller.stub!(:session).and_return session
    controller.stub!(:request).and_return request
    controller.stub!(:params).and_return params
  end

  describe 'logged_in?' do
    it 'should return false when there is no current user' do
      controller.stub!(:current_person).and_return nil
      controller.should_not be_logged_in
    end

    it 'should return false when there is a current user' do
      controller.stub!(:current_person).and_return Object.new
      controller.should be_logged_in
    end
  end

  describe 'require login' do
    it 'should store the request url in session when not logged in' do
      controller.stub!(:root_url).and_return :root_url
      controller.stub!(:logged_in?).and_return false
      request.stub!(:url).and_return :request_url
      controller.should_receive(:redirect_to).with :root_url
      controller.require_login
      session[:initial_url].should  == :request_url
    end

    it 'should skip redirection when logged in' do
      controller.stub!(:logged_in?).and_return true
      controller.should_not_receive :redirect_to
      controller.require_login
      session[:initial_url].should be_nil
    end
  end

  describe 'current_person' do
    it 'should immediately return when @current_person has been determined' do
      controller.instance_variable_set '@current_person', :current_person
      controller.current_person.should == :current_person
    end

    it 'should attempt to lookup user from auth_token if there is one in the request' do
      params[:auth_token] = :token
      Person.stub!(:find_by_auth_token).with(:token).and_return person
      person.should_receive(:email).and_return :email
      controller.current_person.should == person
      session[:email].should == :email
    end

    it 'should return nil if there is no auth_token or email' do
      controller.current_person.should be_nil
    end

    describe 'with session email' do
      before { session[:email] = :session_email }

      it 'should lookup user from session email' do
        Person.should_receive(:find_by_email).with(:session_email).and_return :person
        controller.current_person.should == :person
      end

      it 'should create a new user if one cannot be found from email' do
        Person.should_receive(:find_by_email).with(:session_email).and_return nil
        Person.should_receive(:create_for_email).with(:session_email).and_return :person
        controller.current_person.should == :person
      end

      it 'should replace email with override if email is omnipotent an override is given' do
        params[:override] = :override_email
        Person.should_receive(:find_by_email).with(:override_email).and_return :person
        Omnipotence.should_receive(:omnipotent?).with(:session_email).and_return true
        controller.current_person.should == :person
        session[:email].should == :override_email
      end

      it 'should ignore override if email is not omnipotent' do
        params[:override] = :override_email
        Omnipotence.should_receive(:omnipotent?).with(:session_email).and_return false
        Person.should_receive(:find_by_email).with(:session_email).and_return :person
        controller.current_person.should == :person
        session[:email].should == :session_email
      end
    end
  end
end