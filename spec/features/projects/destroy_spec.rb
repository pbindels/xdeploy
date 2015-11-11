require 'spec_helper'

feature "destroy project" do
  background_basic_login

  background do
    @project = create(:project)
  end

  scenario "user can navigate to the project page and delete the project and be redirected to the projects path" do
    pending
    visit project_path(@project)
    click_link "Delete Project"
    
    current_url.should == projects_url
    
  end
  
  scenario "user can navigate to the project page and delete the project and none should exists" do
    pending
    visit project_path(@project)
    
    click_link "Delete Project"
    
    Project.count.should == 0
  end
end