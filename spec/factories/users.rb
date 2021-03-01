FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.free_email }
    password              { 'hoge123' }
    password_confirmation { password }
    nickname              { Faker::Name.initials(number: 5) }
    last_name             { Gimei.last.kanji }
    first_name            { Gimei.first.kanji }
    last_name_kana        { Gimei.last.katakana }
    first_name_kana       { Gimei.first.katakana }
    self_introduction     { Faker::Base.regexify('[a-z]{50}') }
  end
end
