# Read about factories at https://github.com/thoughtbot/factory_girl

require_relative '../random_generator'

FactoryGirl.define do
  factory :visa_source do
    name Faker::Hacker.noun
    country RandomGenerator.country
    url Faker::Internet.url
    description Faker::Hacker.say_something_smart
    visa_required RandomGenerator.bool
    on_arrival RandomGenerator.bool

    if RandomGenerator.bool
      etag Faker::Number.digit
    else
      last_modified Time.now
    end
  end
end
