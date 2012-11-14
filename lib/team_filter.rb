module TeamFilter
  def with_team
    @team = Team.find_by_slug params[:slug]
    unless current_person.blessed?(@team)
      @team = nil unless current_person.teams.include?(@team) or @team.creator == current_person
    end
    if @team
      yield @team
    else
      render :unknown
    end
  end
end