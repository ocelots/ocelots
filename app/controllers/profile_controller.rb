require 'soundcloud'

class ProfileController < ApplicationController
  include Soundcloud
  before_filter :current_person

  def update
    process_sc_embed_code current_person, current_person
    if current_person.update_attributes params[:person]
      redirect_to profile_url, notice: 'Profile successfully updated.'
    else
      render :edit
    end
  end
end