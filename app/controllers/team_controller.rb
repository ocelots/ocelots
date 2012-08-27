class TeamController < ApplicationController
  def show
    @team = Team.find_by_slug params[:slug]
    unless current_person.blessed?
      @team = nil unless current_person.teams.include? @team
    end
    render :unknown_team unless @team
  end
end