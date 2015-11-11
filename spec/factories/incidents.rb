# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incident do
    start_date "2013-06-10 11:16:01"
    end_date "2013-06-10 11:16:01"
    title "MyString"
    content "MyText"
    tag "MyString"
  end
end
