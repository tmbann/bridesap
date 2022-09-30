FactoryBot.define do
  factory :pose do
    association :user
    shoulder_width { 170 }
  end
end