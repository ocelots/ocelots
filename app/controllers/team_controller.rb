class TeamController < ApplicationController
  def show
    @team = Team.find_by_slug params[:slug]
    @team = nil unless current_person.teams.include? @team
    render :unknown_team unless @team
  end
end