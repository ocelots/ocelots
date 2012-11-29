require 'soundcloudvalidate'

class ProfileController < ApplicationController
  include Soundcloudvalidate
  before_filter :current_person

  def update
    process_sc_embed_code current_person, current_person
    if current_person.update_attributes params[:person]
      redirect_to profile_url, notice: 'Profile successfully updated.'
    else
      render :edit
    end
  end

  def renew_auth
    json = current_person.refresh_auth_token
    render text: json
  end
end