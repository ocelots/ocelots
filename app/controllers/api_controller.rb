class ApiController < ApplicationController
  def profile
    person = Person.find_by_persona_id params[:persona_id]
    person = nil unless current_person.allowed_to_view? person
    if person
      render json: person.api_attributes
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def team
    team = Team.find_by_slug params[:slug]
    team = nil unless current_person.allowed_to_view_team? team
    if team
      render json: team.api_attributes(include: [:members])
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def memberships
    render json: Membership.api_attributes_for(current_person)
  end
end