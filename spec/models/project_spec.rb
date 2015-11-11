require 'spec_helper'

describe Project do

  describe "associations" do

    it { should have_many(:tokens) }
    it { should have_many(:services) }
    it { should have_many(:artifacts) }
    it { should have_many(:environments) }
    it { should have_many(:deployments) }
    it { should have_many(:projects_repositories) }
    it { should have_many(:repositories) }
  end

  describe "validations" do
    it{ should validate_presence_of(:name) }
    it{ should validate_presence_of(:code) }
    it{ should validate_uniqueness_of(:name) }
    it{ should validate_uniqueness_of(:code) }
  end
  
  describe "helpers" do
    describe "deployer_path" do
      it "should return back the project path for the deployer" do
        project = build(:project)
        project.project_path.should == File.join(Rails.configuration.qdeploy.path_prefix, project.code, 'qdeploy' )
      end
    end

    describe "services_path" do
      it "should return back the project path for the deployer" do
        project = build(:project)
        project.services_path.should == File.join(project.project_path, 'services' )
      end
    end
  end
  
  
end