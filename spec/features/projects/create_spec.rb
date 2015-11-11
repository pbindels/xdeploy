require 'spec_helper'

feature 'Creating new Project' do
  background_basic_login

  scenario "with valid attributes" do
    visit projects_path
    click_link "New Project"
    
    name = Forgery(:name).company_name
    
    fill_in :project_name, with: name
    fill_in :project_code, with: Forgery(:currency).code
    fill_in :project_description, with: Forgery(:lorem_ipsum).sentences(1)
    click_button "Create Project"
      
    find("h1").should have_content(name)

  end
  
  scenario "name, code, and description were not filled in" do
    
    visit projects_path
      
    click_link "New Project"
    click_button "Create Project"
    
    assert_selector "div .error", :count => 2

  end

end
