class TimelineController < ApplicationController
  layout false
  def index
    respond_to do |format|
      format.json { render :json => Incident.as_json }
      format.html {}
    end
  end
end