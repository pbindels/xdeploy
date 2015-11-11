require 'spec_helper'

describe Deployment do
  describe "associations" do

    it { should belong_to(:project) }
    it { should belong_to(:service) }
    it { should belong_to(:environment) }
    it { should belong_to(:artifact) }
    it { should belong_to(:user) }
  end
  
  describe "helpers" do
    describe "tokens" do
      let(:deployment){ create(:full_deployment) }
      it "should return a hash of tokens" do
        deployment.tokens.should be_a Hash
      end
      
      it "should return a hash with project tokens" do
        project = deployment.project
        token = project.tokens.create(attributes_for(:token))
        deployment.tokens.keys.should include(token.name)
      end
      
      it "should return a hash with 2 values when there is a global and project token" do
        project = deployment.project
        token = project.tokens.create(attributes_for(:token))
        create(:token)
        deployment.tokens.keys.count.should == 8
      end
      
      it "should return a hash with 1 value if there is a global and project token with the same name" do
        project = deployment.project
        token = project.tokens.create(attributes_for(:token))
        Token.create(name: token.name, value: token.value)
        deployment.tokens.keys.count.should == 7
      end
      
      it "should return a hash with 3 values when there is a global and project and service token" do
        deployment.project.tokens.create(attributes_for(:token))
        deployment.service.tokens.create(attributes_for(:token))
        create(:token)
        deployment.tokens.keys.count.should == 9
      end
      
      it "should return a hash with 3 values when there is a global and project service and environment token" do
        deployment.project.tokens.create(attributes_for(:token))
        deployment.service.tokens.create(attributes_for(:token))
        deployment.environment.tokens.create(attributes_for(:token))
        create(:token)
        deployment.tokens.keys.count.should == 10

      end
    end
    
    describe 'properties' do
      let(:deployment){ create(:full_deployment) }
      it "should return back a string of properties" do

        deployment.project.tokens.create(attributes_for(:token))
        deployment.tokens.first

        deployment.properties.should =~ /^#{deployment.tokens.first[0]}=#{deployment.tokens.first[1]}/
      end
    end
    
    describe "lock_file" do
      let(:deployment){ create(:full_deployment) }

      it "should return back a file" do
        dir = File.dirname(deployment.lock_file_path)
        FileUtils.mkdir_p dir
        FileUtils.touch deployment.lock_file_path
        deployment.lock_file.should be_a File
      end
    end
    
    describe "lock_file_path" do
      let(:deployment){ create(:full_deployment) }
      
      it "should return back a string with" do
        deployment.lock_file_path.should be_a String
      end
    end
  end
end
