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
      message = Message.create team: team, person: current_person, content: params[:content]
      render partial: 'shared/one_message', locals: {message: message}
    end
  end

  def destroy
    message = Message.find params[:id]
    if message
      message.destroy if message.person == current_person
      redirect_to "/antechamber/#{message.team.slug}"
    else
      redirect_to '/teams'
    end
  end
end