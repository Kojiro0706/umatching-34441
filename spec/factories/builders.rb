FactoryBot.define do
  factory :builder do
    title {'あいうえお'}
    description {'あいうえおかきくけこ'}
    category_id {2}
    place {'競馬場'}
    association :user

    after(:build) do |builder|
      builder.image.attach(io: File.open('public/images/test1.png'), filename: 'test1.png')
    end
  end
end
