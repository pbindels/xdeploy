require 'spec_helper'

feature "Creating new tokens" do
  background_basic_login

  context 'global' do
    scenario " with valid attributes" do
      visit tokens_path
      find("a#new-global-token-link").click
      
      fill_in :token_name, with: "ENV"
      fill_in :token_value, with: "PROD"
      
      click_button "Create Token"
      Token.count.should == 1
    end
  end
end