class ApiController < ApplicationController
  def profile
    @person = Person.find_by_persona_id params[:persona_id]
    unless current_person.blessed?
      @person = nil if @person and (current_person.teams & @person.teams).empty?
    end
    if @person
      render json: @person.api_attributes
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def teams
    render json: Membership.api_attributes_for(current_person)
  end
end