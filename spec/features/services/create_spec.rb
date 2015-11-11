require 'spec_helper'

feature 'Creating new Project' do
  background_basic_login
  
  background do
    @project = create(:project)
    visit new_project_service_path(@project.to_param)
  end

  scenario "with valid attributes" do
    name = Forgery(:name).company_name

    fill_in :service_name, with: name
    fill_in :service_code, with: Forgery(:currency).code
    fill_in :service_description, with: Forgery(:lorem_ipsum).sentences(1)
    click_button "Create Service"
    
    find("h1").should have_content(name)
    Service.count.should == 1
  end
  
  scenario "name, code, and description were not filled in" do
    click_button "Create Service"
    
    assert_selector "div .error", :count => 2
    Service.count.should == 0
  end

end
