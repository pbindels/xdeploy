# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deployment do
    
    trait :with_associations do
      after(:build) do |deployment|
        project     = create(:project)
        service     = create(:service, project: project)
        environment = create(:environment)
        user        = create(:user)
        service.environments << environment
        service.save
        artifact = create(:artifact, project: project, service: service)
        
        deployment.user         = user
        deployment.project      = project
        deployment.artifact     = artifact
        deployment.service      = service
        deployment.environment  = environment
      end
    end
    
    factory :full_deployment, traits: [:with_associations]
  end
end
