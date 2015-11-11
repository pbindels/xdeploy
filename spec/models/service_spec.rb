require 'spec_helper'

describe Service do

  describe "associations" do

    it { should belong_to(:project) }
    it { should have_many(:tokens) }
    it { should have_many(:service_to_environments) }
    it { should have_many(:environments) }

    it { should have_many(:artifacts) }
  end

  describe "validations" do
    it{ should validate_presence_of(:name) }
    it{ should validate_presence_of(:code) }
  end
  
  describe "helpers" do

    describe 'lock_file' do

      it "should return back a string with the lock file path" do
        service = create(:full_service)
        service.lock_file("dev").should be_a String
      end

    end
    
    describe 'locked?' do
      let(:service){create(:full_service)}
      it 'should return back if the environment is locked' do
        File.stub(:exists?).and_return(true)
        service.locked?("dev").should be_true
      end

      it 'should return back false if the environment is not locked' do
        File.stub(:exists?).and_return(false)
        
        service.locked?("dev").should be_false
        
      end
    end
    
    describe 'service_path' do
      let(:service){create(:full_service)}
      it "should return back the path to the service" do
        service.service_path.should == File.join(service.project.project_path, service.code)
      end
      
    end
    
    describe 'deployment_logs_path' do
      let(:service){create(:full_service)}
      it "should return the path to the deployment logs" do
        service.deployment_logs_path.should == File.join(service.service_path, 'var')
      end
    end

  end

end
