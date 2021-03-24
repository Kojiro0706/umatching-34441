FactoryBot.define do
  factory :user do
    name { 'test' }
    email                 { Faker::Internet.free_email }
    password              { 'abc123' }
    password_confirmation { password }
    profile               { 'あいうえお' }
    history               { 1 }
    horse                 { 'カキクケコ' }

    after(:build) do |user|
      user.image.attach(io: File.open('public/images/test1.png'), filename: 'test1.png')
    end
  end
end
