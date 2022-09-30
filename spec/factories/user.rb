FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "ニックネーム#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    role { "general" }
  
    after(:create) do |user|
      create(:pure_pose, user: user)
      create(:pose, user: user)
    end
  end
end