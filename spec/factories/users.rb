FactoryBot.define do
  factory :user do
    # email { "user@example.com" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'secret'}
  end
end