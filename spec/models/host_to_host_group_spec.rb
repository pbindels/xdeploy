require 'spec_helper'

describe HostToHostGroup do

  describe "associations" do

    it { should belong_to(:host) }
    it { should belong_to(:host_group) }
    it { HostToHostGroup.new.save}
  end
  

  describe "validations" do
  end
  
end