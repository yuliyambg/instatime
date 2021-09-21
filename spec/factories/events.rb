FactoryBot.define do
  factory :event do
    user
    description { 'Italy vacation'}

    factory :public_event do
      is_public { true }
    end

    factory :private_event do
      is_public { false }
    end
  end
end
