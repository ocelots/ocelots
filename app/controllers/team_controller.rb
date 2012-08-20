class TeamController < ApplicationController
  def show
    @team = Team.find_by_slug params[:slug]
  end
end