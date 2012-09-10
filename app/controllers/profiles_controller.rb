class ProfilesController < ApplicationController
  def show
    @person = Person.find_by_account params[:account]
    render :unknown unless @person
  end
end