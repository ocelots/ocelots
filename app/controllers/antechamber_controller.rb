require 'team_filter'

class AntechamberController < ApplicationController
  include TeamFilter

  def index
    with_team do |team|
      @messages = team.messages.order('created_at desc').limit(50)
    end
  end

  def create
    with_team do |team|
      Message.create team: team, person: current_person, content: params[:content]
      redirect_to "/antechamber/#{team.slug}"
    end
  end
end