FactoryBot.define do
  factory :user do
    name { 'test' }
    email                 { Faker::Internet.free_email }
    password              { 'abc123' }
    password_confirmation { password }
    profile               { 'あいうえお' }
    history               { 1 }
    horse                 { 'カキクケコ' }
  end
end
