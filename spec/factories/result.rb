FactoryBot.define do
  factory :result do
    association :user
    association :pose
    score { 30 }
    comment { "自己ベスト！" }
  end
end