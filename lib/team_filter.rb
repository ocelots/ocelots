module TeamFilter
  def with_team
		@team = Team.find_by_slug params[:slug]
    unless current_person.allowed_to_view_team?(@team)
      @team = nil
    end
    if @team
      yield @team
    else
      render :unknown
    end
  end
end