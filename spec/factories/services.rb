# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    name { Forgery(:name).company_name}
    code { Forgery(:currency).code }
    description { Forgery(:lorem_ipsum).sentences(1) }

    trait :with_associations do
      after(:build) do |service|
        project     = create(:project)
        service.project = project
      end
    end
    
    factory :full_service, traits: [:with_associations]

  end
end
