FactoryBot.define do
  factory :pure_pose do
    association :user
    pure_shoulder_width { 200 }
  end
end