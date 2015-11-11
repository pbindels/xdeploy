require 'spec_helper'

describe HostGroup do

  describe "associations" do

    it { should have_many(:hosts) }
    it { should have_many(:host_to_host_groups) }

  end

  describe "validations" do

    it{ should validate_presence_of(:name) }
    it{ should validate_uniqueness_of(:name) }

  end

end
