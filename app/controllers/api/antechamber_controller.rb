require 'team_filter'

module Api
  class AntechamberController < ApplicationController
    include TeamFilter

    def index
      messages = []
      with_team do |team|
        messages = team.messages.order 'created_at desc'
        messages = messages.where 'id > ?', params[:from] if params[:from]
      end
      render json: messages.map(&:api_attributes)
    end

    def create
      message = nil
      with_team do |team|
        message = Message.create team: team, person: current_person, content: params[:content]
      end
      if message and message
        render status: :created, json: message.api_attributes
      else
        render status: :unprocessable_entity
      end
    end
  end
end