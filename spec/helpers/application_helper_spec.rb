require 'spec_helper'

describe ApplicationHelper do

  it "should respond to body_classes" do
    helper.should respond_to(:body_classes)
  end
  
  it "should respond with a string" do
    helper.body_classes.should be_a String
  end
  it "should respond with a string joined by a space" do
    helper.stub(:controller_name).and_return("blogs")
    helper.stub(:action_name).and_return("clogs")
    
    helper.body_classes.should == "blogs clogs"
  end
end