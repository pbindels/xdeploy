require 'spec_helper'

describe DeploymentsController do
  
  before_each_basic_login

  before(:each) do
    DeploymentWorker.stub(:perform).with(any_args).and_return(true)
  end
  
  describe "GET new" do
    before(:each) do
    end
  end

  describe "GET index" do
    before(:each) do
      @deployment = create(:full_deployment)
      @project = @deployment.project
    end
    
    it "should assign @deployments" do
      get :index, {project_id: @project.to_param}
      assigns(:deployments).should eq([@deployment])
    end
      
  end
  
  describe 'POST create' do
    it "should enqueue a new deployment after creation" do
      @project = create(:project)
      @service = create(:service, project: @project)
      @environment = create(:environment)
      @service.environments << @environment
      @artifact = create(:artifact, project: @project, service: @service)  

      post :create, {project_id: @project.id, service_id: @service.id, environment_id: @environment, artifact_id: @artifact.id, format: :js}
      expect(DeploymentWorker).to have(1).enqueued.jobs
    end
    it "should create a new public activie" do
      @project = create(:project)
      @service = create(:service, project: @project)
      @environment = create(:environment)
      @service.environments << @environment
      @artifact = create(:artifact, project: @project, service: @service)
  
      expect{
        post :create, {project_id: @project.id, service_id: @service.id, environment_id: @environment, artifact_id: @artifact.id, format: :js}
      }.to change(PublicActivity::Activity, :count).by(1)
    end
  end
  
  describe "GET new" do
    let(:project){ create(:project)}
    let(:environment){ create(:environment) }
    let(:service){ 
      s = create(:service, project: project) 
      s.environments << environment
      s.save
      s
    }
    
    let(:artifact){ create(:artifact, project: project, service: service)}

    it "should assign project if the project id is passed" do
      get :new, { project_id: project.to_param }
      assigns(:project).should == project
    end
    
    it "should assign @project if no project id is passed" do
      project
      get :new, {}
      assigns(:projects).should eq([project])
    end
    
    it "should assign service if the service id is passed" do
      get :new, { project_id: project.to_param, service_id: service.to_param }
      assigns(:service).should == service
    end

    it "should assign service if the service id is passed" do
      get :new, { project_id: project.to_param, service_id: service.to_param }
      assigns(:environments).should eq(service.environments)
    end
    
    it "should assign artifacts if the environment id is passed" do
      get :new, { project_id: project.to_param, service_id: service.to_param, environment_id: environment.to_param }
      assigns(:environment).should eq environment
    end
    
    it "should assign artifacts if the environment id is passed" do
      get :new, { project_id: project.to_param, service_id: service.to_param, environment_id: environment.to_param }
      assigns(:artifacts).should eq([artifact])
    end
    
    it "should assign artifact if the artifact id is passed" do
      get :new, { project_id: project.to_param, service_id: service.to_param, environment_id: environment.to_param, artifact_id: artifact.to_param }
      assigns(:artifact).should eq artifact
    end
    
  end
  
  describe 'GET tokens' do
    it 'should return back a list of tokens' do
      deployment = create(:full_deployment)
      get :tokens, {id: deployment.to_param}
      response.body.split("\n").size.should == 6
    end
  end
  
end