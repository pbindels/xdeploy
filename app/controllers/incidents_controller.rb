class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  # GET /incidents
  def index
    @incidents = Incident.all
  end

  # GET /incidents/1
  def show
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents
  def create
    @incident = Incident.new(incident_params)

    if @incident.save
      redirect_to incidents_path, notice: 'Incident was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /incidents/1
  def update
    if @incident.update(incident_params)
      redirect_to incidents_path
    else
      render action: 'edit'
    end
  end

  # DELETE /incidents/1
  def destroy
    @incident.destroy
    redirect_to incidents_url, notice: 'Incident was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def incident_params
      params.require(:incident).permit(:start_date, :title, :content, :tag)
    end
end
