# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :token do
    name { Forgery(:name).company_name}
    value { Forgery(:lorem_ipsum).word }
  end
end
