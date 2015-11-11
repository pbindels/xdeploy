class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_environment, :remove_environment]

  # GET /projects
  def index
    @projects = Project.all
  end

  # GET /projects/1
  def show
    @tokenable = @project
    @token = @project.tokens.build
    @services = @project.services.to_a
    @service = @project.services.build
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        @project.create_activity key: 'project.create', owner: current_user
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.js
      else
        format.html { render action: 'new' }
        format.js{ render :json => @project.errors }
      end
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      @project.create_activity key: 'project.update', owner: current_user
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url
  end



  def add_environment
    @environment = Environment.find(params[:environment_id])
    @project.environments << @environment
  end

  def remove_environment
    @environment = Environment.find(params[:environment_id])
    ProjectToEnvironment.find_by(environment_id: @environment.id, project_id: @project.id).destroy
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :code, :description, :recipients)
    end
end
