require 'spec_helper'

feature "Login with basic auth" do
  background_basic_login
  
  scenario "after passing basic auth my user should be created" do
    
    name = Forgery(:name).first_name
    
    set_basic_auth_header(name)

    visit "/"
    page.should have_content name
  end
end