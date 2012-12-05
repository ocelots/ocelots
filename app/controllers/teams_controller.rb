require 'team_filter'
require 'mail'

class TeamsController < ApplicationController
  include TeamFilter

  def index
    @memberships = current_person.memberships.select { |membership| membership.ended==nil }
    @team = Team.new
    @organisations = Organisation.find(:all)
  end

  def create
    @teams = current_person.teams
    @team = Team.new params[:team].merge creator: current_person
    if @team.save
      if org = current_person.organisation
        org.teams << @team
      end

      current_person.teams << @team

      redirect_to "/teams/#{@team.slug}"
    else
      @memberships = current_person.memberships
      render :index
    end
  end

  def add
    with_team do |team|
      begin
        current_person.invite(params[:emails], team)
        message = 'All people invited'
        result_status = 'success'
      rescue => error
        message = error.to_s
        result_status = 'failed'
      end

      respond_to do |format|
        format.json { render :json => {:message => message, :status => result_status} }
      end
    end
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
      @person = team.people.select {|person| !person.facts.empty?}.sample
      if @person
        @facts = @person.facts.sample 3
        render :quiz
      else
        render :nofacts
      end
    end
  end

  def join
    with_team do |team|
      current_person.join team
      redirect_to "/teams/#{team.slug}"
    end
  end

  def quit
    with_team do |team|
      current_person.leave team
    end
    redirect_to "/teams"
  end
end