require 'spec_helper'

describe DashboardController do

  before_each_basic_login
  
  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

end
