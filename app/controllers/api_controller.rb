class ApiController < ApplicationController
  def profile
    @person = Person.find_by_account params[:account]
    unless current_person.blessed?
      @person = nil if @person and (current_person.teams & @person.teams).empty?
    end
    if @person
      render json: @person.api_attributes
    else
      render json: {}, status: :unprocessable_entity
    end
  end
end