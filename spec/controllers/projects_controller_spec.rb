require 'spec_helper'

describe ProjectsController do
  before_each_basic_login
  
  let(:project){ create(:project) }

  describe "GET show" do
    it "assigns the requested project as @project" do
      get :show, {:id => project.to_param}
      assigns(:project).should eq(project)
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      get :new, {}
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      get :edit, {:id => project.to_param}
      assigns(:project).should eq(project)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, {:project => attributes_for(:project)}
        }.to change(Project, :count).by(1)
      end

      it "assigns a newly created project as @project" do
        post :create, {:project => attributes_for(:project)}
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end

      it "redirects to the created project" do
        post :create, {:project => attributes_for(:project)}
        response.should redirect_to(project_path(Project.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => { "name" => "invalid value" }}
        assigns(:project).should be_a_new(Project)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested project" do
        Project.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => project.to_param, :project => { "name" => "MyString" }}
      end

      it "assigns the requested project as @project" do
        
        put :update, {id: project.to_param, :project => attributes_for(:project)}
        assigns(:project).should eq(project)
      end

      it "redirects to the project" do
        
        put :update, {id: project.to_param, :project => attributes_for(:project)}
        response.should redirect_to(project_path(project))
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
      
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        put :update, {:id => project.to_param, :project => { "name" => "invalid value" }}
        assigns(:project).should eq(project)
      end

      it "re-renders the 'edit' template" do
        
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        put :update, {:id => project.to_param, :project => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      project
      expect {
        delete :destroy, {:id => project.to_param}
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      delete :destroy, {:id => project.to_param}
      response.should redirect_to(projects_url)
    end
  end

end