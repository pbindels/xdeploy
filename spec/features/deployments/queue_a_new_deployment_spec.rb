require 'spec_helper'


feature 'queue a new deployment', js: true do
  background_basic_login

  background do
    @project = create(:project)
    @service = create(:service, project: @project)
    @environment = create(:environment)
    @service.environments << @environment
    @service.save
    @artifact = create(:artifact, project: @project, service: @service)
  end
  
  scenario 'clicking through the deployment popup', js: true do
    expect{
      visit root_path
      
      click_link "Deploy!"
      
      find("#deployment-link-project-#{@project.id}").click
      click_link @service.name
      click_link @environment.name
      select @artifact.name, from: :artifact_id

      click_button "Deploy"
      
    }.to change(Deployment, :count).by(1)
  end
end