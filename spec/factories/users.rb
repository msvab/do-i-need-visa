# Read about factories at https://github.com/thoughtbot/factory_girl

require_relative '../random_generator'

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password 'Password1!'
  end
end
