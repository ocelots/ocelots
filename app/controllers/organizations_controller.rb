class OrganizationsController < ApplicationController
  def index
    @organizations = Organisation.all
    respond_to do |format|
      format.json  { render :json => @organizations }
    end
  end

end
