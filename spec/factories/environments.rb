# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :environment do
    name { Forgery(:lorem_ipsum).words(2) }
    code { Forgery(:currency).code }
    sequence(:env_id){ |n| n }
  end
end