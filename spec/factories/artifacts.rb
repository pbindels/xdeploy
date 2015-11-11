# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artifact do
    name { "release_" + Forgery(:basic).number(:at_least => 3).to_s }
    file_path { "/tmp/release_" + Forgery(:basic).number(:at_least => 3 ).to_s }
  end
end
