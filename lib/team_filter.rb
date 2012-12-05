module TeamFilter
  def with_team (slug = nil)
	  if slug
		  @team = Team.find_by_slug slug
		else
		  @team = Team.find_by_slug params[:slug]
		end
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