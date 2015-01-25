# Read about factories at https://github.com/thoughtbot/factory_girl

require 'securerandom'
require_relative '../random_generator'

FactoryGirl.define do
  factory :visa_source do
    name Faker::Hacker.noun
    country RandomGenerator.country
    url Faker::Internet.url
    description Faker::Hacker.say_something_smart
    visa_required RandomGenerator.bool
    on_arrival RandomGenerator.bool
    page_hash SecureRandom.hex(16)
  end
end
