require 'soundcloud'

class ProfileController < ApplicationController
  include Soundcloud
  before_filter :current_person

  def update
    process_sc_embed_code @person, @person
    if @person.update_attributes params[:person]
      redirect_to '/', notice: 'Profile successfully updated.'
    else
      render action: 'edit'
    end
  end
end