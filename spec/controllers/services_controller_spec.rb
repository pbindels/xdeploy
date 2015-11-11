require 'spec_helper'

describe ServicesController do
  before_each_basic_login
  
  let(:project){ create(:project) }
  let(:service){ create(:service, project: project) }

  describe "GET show" do
    it "assigns the requested service as @service" do
      get :show, {:id => service.to_param, project_id: project.to_param}
      assigns(:service).should eq(service)
    end
  end

  describe "GET new" do
    it "assigns a new service as @service" do
      get :new, {project_id: project.to_param}
      assigns(:service).should be_a_new(Service)
    end
  end

  describe "GET edit" do
    it "assigns the requested service as @service" do
      get :edit, {:id => service.to_param, project_id: project.to_param}
      assigns(:service).should eq(service)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Service" do
        expect {
          post :create, {:service => attributes_for(:service), project_id: project.to_param}
        }.to change(Service, :count).by(1)
      end

      it "assigns a newly created service as @service" do
        post :create, {:service => attributes_for(:service), project_id: project.to_param}
        assigns(:service).should be_a(Service)
        assigns(:service).should be_persisted
      end

      it "redirects to the created service" do
        post :create, {:service => attributes_for(:service), project_id: project.to_param}
        response.should redirect_to(project_service_path(project, Service.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved service as @service" do
        # Trigger the behavior that occurs when invalid params are submitted
        Service.any_instance.stub(:save).and_return(false)
        post :create, {:service => { "name" => "invalid value" }, project_id: project.to_param}
        assigns(:service).should be_a_new(Service)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Service.any_instance.stub(:save).and_return(false)
        post :create, {:service => { "name" => "invalid value" }, project_id: project.to_param}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested service" do
        Service.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => service.to_param, :service => { "name" => "MyString" }, project_id: project.to_param}
      end

      it "assigns the requested service as @service" do
        
        put :update, {id: service.to_param, :service => attributes_for(:service), project_id: project.to_param}
        assigns(:service).should eq(service)
      end

      it "redirects to the service" do
        
        put :update, {id: service.to_param, :service => attributes_for(:service), project_id: project.to_param}
        response.should redirect_to(project_service_path(project, service))
      end
    end

    describe "with invalid params" do
      it "assigns the service as @service" do
      
        # Trigger the behavior that occurs when invalid params are submitted
        Service.any_instance.stub(:save).and_return(false)
        put :update, {:id => service.to_param, :service => { "name" => "invalid value" }, project_id: project.to_param}
        assigns(:service).should eq(service)
      end

      it "re-renders the 'edit' template" do
        
        # Trigger the behavior that occurs when invalid params are submitted
        Service.any_instance.stub(:save).and_return(false)
        put :update, {:id => service.to_param, :service => { "name" => "invalid value" }, project_id: project.to_param}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested service" do
      service
      expect {
        delete :destroy, {:id => service.to_param, project_id: project.to_param}
      }.to change(Service, :count).by(-1)
    end

    it "redirects to the services list" do
      delete :destroy, {:id => service.to_param, project_id: project.to_param}
      response.should redirect_to(project_services_url(project))
    end
  end

  describe "POST add_environment" do
    let(:environment){ create(:environment) }
    it "adds an environment to the service" do
      expect{
        post :add_environment, {id: service.to_param, project_id: project.to_param, environment_id: environment.to_param, format: :js}
      }.to change(service.environments, :count).by(1)
    end
  end

end