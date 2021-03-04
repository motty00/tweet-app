FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    tweet { nil }
  end
end
