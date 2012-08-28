class TeamController < ApplicationController
  def show
    show_team :show
  end

  def avatars
    show_team :avatars, layout: 'no_header'
  end
private
  def show_team *args
    @team = Team.find_by_slug params[:slug]
    unless current_person.blessed?
      @team = nil unless current_person.teams.include? @team
    end
    if @team
      render *args
    else
      render :unknown_team
    end
  end
end