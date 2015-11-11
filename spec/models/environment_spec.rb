require 'spec_helper'

describe Environment do

  describe "associations" do

    it { should have_many(:tokens) }

  end

  describe "validations" do

    it{ should validate_presence_of(:name) }
    it{ should validate_uniqueness_of(:name) }
    it{ should validate_uniqueness_of(:code) }
    it{ should validate_presence_of(:env_id) }

  end

end
