# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :visa_source do
    name Faker::Hacker.noun
    country 'US'
    url Faker::Internet.url
    description Faker::Hacker.say_something_smart

    if Random.rand(2) == 1
      etag Faker::Number.digit
    else
      last_modified Time.now
    end
  end
end
