class FactController < ApplicationController
  def create
    Fact.create person: current_person, content: params[:content]
    redirect_to '/profile#facts'
  end

  def destroy
    fact = Fact.find params[:id]
    fact.destroy if fact.person = current_person
    redirect_to '/profile#facts'
  end
end