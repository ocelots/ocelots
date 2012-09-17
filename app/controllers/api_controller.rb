class ApiController < ApplicationController
  def profile
    @person = Person.find_by_persona_id params[:persona_id]
    @person = nil unless current_person.allowed_to_view? @person
    if @person
      render json: @person.api_attributes
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def memberships
    render json: Membership.api_attributes_for(current_person)
  end
end