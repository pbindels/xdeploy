require 'spec_helper'

describe ArtifactsController do

  before_each_basic_login
  
  describe "POST 'create'" do
    it "returns http success" do
      deployment = create(:full_deployment)
      
      post 'create', { file_path: '/home/blah.zip', project_code: deployment.project.code, service_code: deployment.service.code }
      response.should be_success
    end

    it "returns http failure" do
      expect{
        post 'create'
      }.to raise_error
    end
    
    it "returns a 500" do
      deployment = create(:full_deployment)
      Artifact.any_instance.stub(:save).and_return(false)

      post 'create', { file_path: '/home/blah.zip', project_code: deployment.project.code, service_code: deployment.service.code }
      response.status.should == 500
    end

  end

end
