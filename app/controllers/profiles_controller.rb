class ProfilesController < ApplicationController
  def show
    @person = Person.find_by_account params[:account]
    @person = nil unless current_person.allowed_to_view? @person
    render :unknown unless @person
  end
end