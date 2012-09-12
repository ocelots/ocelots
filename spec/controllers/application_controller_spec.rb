require 'spec_helper'

describe ApplicationController do
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
    let(:session) { stub 'session' }
    let(:request) { stub 'request', url: :the_url }

    before do
      controller.stub!(:session).and_return session
      controller.stub!(:request).and_return request
      controller.stub!(:root_url).and_return :root_url
    end

    after { controller.require_login }

    it 'should store the initial url in session when not logged in' do
      controller.stub!(:logged_in?).and_return false
      session.should_receive(:[]=).with :initial_url, :the_url
      controller.should_receive(:redirect_to).with :root_url
    end
  end
end