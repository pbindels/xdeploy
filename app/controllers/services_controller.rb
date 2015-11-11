class ServicesController < ApplicationController
  before_action :set_project
  before_action :set_service, only: [:show, :edit, :update, :destroy, :add_environment, :remove_environment]

  # GET /services
  def index
    @services = @project.services
  end

  # GET /services/1
  def show
  end

  # GET /services/new
  def new
    @service = @project.services.build
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  def create
    @service = @project.services.build(service_params)

    respond_to do |format|
      if @service.save
        @service.create_activity key: 'service.create', owner: current_user
        format.html{redirect_to project_service_path(@project, @service), notice: 'Service was successfully created.'}
        format.js
      else
        format.html{render action: 'new'}
        format.js
      end
    end
  end

  # PATCH/PUT /services/1
  def update
    if @service.update(service_params)
      @service.create_activity key: 'service.update', owner: current_user
      redirect_to project_service_path(@project,@service), notice: 'Service was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    redirect_to project_services_url(@project)
  end

  def add_environment
    @environment = Environment.find(params[:environment_id])
    @service.environments << @environment
  end

  def remove_environment
    @environment = Environment.find(params[:environment_id])
    ServiceToEnvironment.find_by(environment_id: @environment.id, service_id: @service.id).destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = @project.services.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name, :code, :description, :project_id)
    end
end
