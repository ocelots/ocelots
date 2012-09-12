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
end