class ArtifactsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    @artifact = Artifact.new
    
    @artifact.name      = File.basename params[:file_path]
    @artifact.file_path = params[:file_path]
    @artifact.project   = Project.find_by code: params[:project_code]
    @artifact.service   = Service.find_by code: params[:service_code]

    if @artifact.save
      render nothing: true, status: 200
    else
      render nothing: true, status: 500
    end
  end

end
