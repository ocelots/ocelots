class ProfileController < ApplicationController
  before_filter :find_or_create_person

  def update
    if @person.update_attributes params[:person]
      redirect_to '/', notice: 'Profile successfully updated.'
    else
      render action: 'edit'
    end
  end
private
  def find_or_create_person
    @person = Person.find_by_email @current_user
    @person = Person.create email: @current_user unless @person
  end
end