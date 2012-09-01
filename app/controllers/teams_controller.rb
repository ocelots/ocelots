class TeamsController < ApplicationController
  def index
    @teams = current_person.teams
    @team = Team.new
  end

  def create
    if current_person.blessed?
      team = Team.create params[:team]
      redirect_to "/teams/#{team.slug}"
    else
      redirect_to :teams
    end
  end

  def add
    if current_person.blessed?
      team = Team.find_by_slug params[:slug]
      person = Person.find_by_email params[:email]
      person = Person.create email: params[:email] unless person
      Membership.create team: team, person: person
    end
    redirect_to "/teams/#{team.slug}"
  end

  def show
    with_team { render :show }
  end

  def avatars
    with_team { render :avatars, layout: 'no_header' }
  end

  def quiz
    with_team do |team|
      @people = team.people.sample 5
      @person = @people.sample
      @facts = @person.facts.sample 3
      render :quiz
    end
  end
private
  def with_team *args
    @team = Team.find_by_slug params[:slug]
    unless current_person.blessed?
      @team = nil unless current_person.teams.include? @team
    end
    if @team
      yield @team
    else
      render :unknown_team
    end
  end
end