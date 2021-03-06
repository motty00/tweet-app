FactoryBot.define do
  factory :tweet do
    text { Faker::Base.regexify('[a-z]{20}') }
    association :user
  end
end
