class ProfileController < ApplicationController
  before_filter :current_person

  def update
    if @person.update_attributes params[:person]
      redirect_to '/', notice: 'Profile successfully updated.'
    else
      render action: 'edit'
    end
  end
end