# Read about factories at https://github.com/thoughtbot/factory_girl

def random_bool
  [true, false].sample
end

FactoryGirl.define do
  factory :visa_source do
    name Faker::Hacker.noun
    country 'US'
    url Faker::Internet.url
    description Faker::Hacker.say_something_smart
    visa_required random_bool
    on_arrival random_bool

    if random_bool
      etag Faker::Number.digit
    else
      last_modified Time.now
    end
  end
end
