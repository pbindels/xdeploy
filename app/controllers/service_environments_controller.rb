class ServiceEnvironmentsController < ApplicationController
  before_action :set_service_to_environment
  before_action :set_environment
  before_action :set_service



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_to_environment
      @service_to_environment = ServiceToEnvironment.find(params[:id])
    end
    
    def set_environment
      @environment = @service_to_environment.environment
    end
    
    def set_service
      @service = @service_to_environment.service
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name, :code, :description, :project_id)
    end
end
