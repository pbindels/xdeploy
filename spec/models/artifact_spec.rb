require 'spec_helper'

describe Artifact do
  describe "associations" do

    it { should belong_to(:project) }
    it { should belong_to(:service) }

  end

  describe "validations" do

    it{ should validate_presence_of(:project_id) }
    it{ should validate_presence_of(:service_id) }
    it{ should validate_presence_of(:name)}
    it{ should validate_presence_of(:file_path)}
    it{ should validate_uniqueness_of(:name)}
    it{ should validate_uniqueness_of(:file_path)}

  end

end