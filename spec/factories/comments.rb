FactoryBot.define do
  factory :comment do
    text{'あいうえお'}
    association :user
    association :builder
  end
end
