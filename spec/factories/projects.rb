# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name { Forgery(:name).company_name }
    code { Forgery(:currency).code }
    description { Forgery(:lorem_ipsum).sentences(1) }
  end
end
