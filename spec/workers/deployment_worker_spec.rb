require 'spec_helper'

describe DeploymentWorker do
  
  describe "#perform" do
    before(:each) do
      #DeploymentWorker.stub(:perform).with(any_args).and_return(true)
      Net::SSH.stub(:start).with(any_args()).and_return(true)
    end
    
    it "should take 1 variable" do
      deployment = create(:full_deployment)
      expect{
        DeploymentWorker.new.perform(deployment.id)
      }.to_not raise_error
    end
    
    it "should set the started_at" do
      deployment = create(:full_deployment)
      DeploymentWorker.new.perform(deployment.id)
      deployment.reload.started_at.should be_a Time
    end
    
    it "should set the ended_at" do
      deployment = create(:full_deployment)
      DeploymentWorker.new.perform(deployment.id)
      deployment.reload.ended_at.should be_a Time
    end
  end
end

