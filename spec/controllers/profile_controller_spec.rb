require 'spec_helper'

describe ProfileController do
  render_views
  
  describe :update do
    before(:each) do
      @person = sign_in
    end
    
    it 'updates profile' do
      post :update, person: {full_name: 'Test User'}
      @person.reload.full_name.should == 'Test User'
    end
    
    it 'does not update profile with valid value' do
      post :update, person: {full_name: ''}
      @person.reload.full_name.should_not == ''
    end
  end
end