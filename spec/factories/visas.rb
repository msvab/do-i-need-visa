# Read about factories at https://github.com/thoughtbot/factory_girl

require_relative '../random_generator'

FactoryGirl.define do
  factory :visa do
    citizen RandomGenerator.country
  end
end
